unit fDomande;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Data.DbxSqlite, Data.FMTBcd, Data.SqlExpr, Vcl.DBCtrls, Data.DBXTrace,
  Data.DBXMySQL, Vcl.ExtCtrls, DateUtils, Vcl.CheckLst, UITypes;

type
  TfDomanda = class(TForm)
    memoTestoDomanda: TMemo;
    lbIntestazioneDomanda: TLabel;
    dbConnection: TSQLConnection;
    qDomanda: TSQLQuery;
    rgRisposte: TRadioGroup;
    btDaiRisposta: TButton;
    qRisposte: TSQLQuery;
    uDomanda: TSQLQuery;
    uRisposta: TSQLQuery;
    memoNoteRispostaEsatta: TMemo;
    qRisposta: TSQLQuery;
    lbEsatte: TLabel;
    lbContatore: TLabel;
    Timer1: TTimer;
    lbTimer: TLabel;
    clbRisultato: TCheckListBox;
    procedure FormShow(Sender: TObject);
    procedure btDaiRispostaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function IfNull(const Value, Default: OleVariant): OleVariant;
    function SecsToHmsStr(ASecs: integer): string;
    procedure Timer1Timer(Sender: TObject);
  private
    var
      capitoli: array of byte;
      domande: array of byte;
      esatte: array of boolean;
      currentIndex: byte;
      esatteCont: byte;
      procedure NextDomanda;
      procedure DataRispostaEsatta;
      procedure DataRispostaErrata;
      procedure FineQuiz;
  public
    var
      capitolo: byte;
      numDomande: byte;
      casuali: boolean;
      tempoConcesso: integer;
  end;

implementation

{$R *.dfm}
(*
*)
procedure TfDomanda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dbConnection.Close;
  Timer1.Enabled := false;
end;  // FormClose()

(*
*)
procedure TfDomanda.FormShow(Sender: TObject);
  var
    i, j: byte;
    domandaSelezionata: byte;
    capitoloSelezionato: byte;
    TimeOut: TDateTime;
begin
  if casuali then begin
    SetLength(capitoli, numDomande);
    SetLength(domande, numDomande);
    SetLength(esatte, numDomande);
    i := 0;
    while i < numDomande do
    begin
      domandaSelezionata := Random(21)+1;
      if (domandaSelezionata = 21) then
        capitoloSelezionato := 13
      else
        capitoloSelezionato := Random(18)+1;

      j := 0;
      while (j < i) and
            ( (capitoloSelezionato <> capitoli[j]) or
              (domandaSelezionata <> domande[j]) ) do
        Inc(j);

      if j = i then
      begin
        domande[i] := domandaSelezionata;
        capitoli[i] := capitoloSelezionato;
        Inc(i);
      end; // if

    end; // while
  end else begin
    if capitolo = 13 then numDomande := 21 else numDomande := 20;
    SetLength(capitoli, numDomande);
    SetLength(domande, numDomande);
    SetLength(esatte, numDomande);
    for i := 0 to numDomande-1 do
    begin
      capitoli[i] := capitolo;
      domande[i] := i+1;
    end; //for
  end; // if..else

  for i := 1 to numDomande do
    clbRisultato.Items.Append('#'+ IntToStr(i) +' Cap. '+ IntToStr(capitoli[i-1]) +' Dom. ' +IntToStr(domande[i-1]));

  currentIndex := 0;
  esatteCont := 0;
  dbConnection.Open;

  TimeOut := IncSecond(Now, tempoConcesso);
  Timer1.Enabled := True;
  lbTimer.Caption := 'Tempo Rimasto '+ SecsToHmsStr(SecondsBetween(Now, TimeOut));

  NextDomanda;
end; // FormShow()

(*
*)
procedure TfDomanda.NextDomanda;
  var
    risposta: String;
begin
  lbEsatte.Caption := 'Risposte Esatte: '+IntToStr(esatteCont);
  if(currentIndex < numDomande) then
    begin
      lbIntestazioneDomanda.Caption :=
        'Capitolo ' + intToStr(capitoli[currentIndex]) +
        ' Domanda numero ' + intToStr(domande[currentIndex]);
      lbContatore.Caption := 'Domanda '+ IntToStr(currentIndex+1) +' di '+ IntToStr(numDomande);
      memoNoteRispostaEsatta.Clear;

      with qDomanda do begin
        Close;
        ParamByName('capitolo').Value := capitoli[currentIndex];
        ParamByName('numeroDomanda').Value := domande[currentIndex];
        Open;
        memoTestoDomanda.Text := FieldByName('Testo_Domanda').Value;
      end; //with

      with qRisposte do begin
        Close;
        ParamByName('capitolo').Value := capitoli[currentIndex];
        ParamByName('numeroDomanda').Value := domande[currentIndex];
        Open;
        First;
        rgRisposte.Items.Clear;
        while not EOF do begin
          risposta := IfNull ( FieldByName('Testo_Risposta').Value,
                              'Riposta ' + FieldByName('Risposta').Value );
          rgRisposte.Items.Add(risposta);
          Next;
        end; // while
      end; // with
    end // if..then
  else
    FineQuiz;
end; // NextDomanda()

(*
*)
procedure TfDomanda.btDaiRispostaClick(Sender: TObject);
var
  rispostaData: byte;
  rispostaEsatta: byte;
  numVolteData: integer;
begin
  if rgRisposte.ItemIndex = -1 then
  begin
    ShowMessage('Devi dare una risposta');
    exit;
  end;

  memoNoteRispostaEsatta.Text := qDomanda.FieldByName('Nota_Risposta_Esatta').Value;
  rispostaData := rgRisposte.ItemIndex;
  rispostaEsatta := ord( String(qDomanda.FieldByName('Risposta_Esatta').Value)[1] ) - ord('A');
  if rispostaData = rispostaEsatta then
    DataRispostaEsatta
  else
    DataRispostaErrata;

  with qRisposta do begin
    Close;
    ParamByName('capitolo').Value := capitoli[currentIndex];
    ParamByName('numeroDomanda').Value := domande[currentIndex];
    ParamByName('rispostaData').Value := char(rgRisposte.ItemIndex + ord('A'));
    Open;
  end; // with

  with uRisposta do begin
    numVolteData := qRisposta.FieldByName('N_Volte_Data').Value + 1;
    ParamByName('nVolteData').Value := numVolteData;
    ParamByName('capitolo').Value := capitoli[currentIndex];
    ParamByName('numeroDomanda').Value := domande[currentIndex];
    ParamByName('risposta').Value := char(rgRisposte.ItemIndex + ord('A'));
    ExecSQL;
  end; // with

  Inc(currentIndex);
  NextDomanda;
end;

(*
*)
procedure TfDomanda.DataRispostaEsatta;
var
  numRispEsatte: integer;
  numRispErrate: integer;
begin
  clbRisultato.Checked[currentIndex] := true;
  with uDomanda do begin
    numRispEsatte := qDomanda.FieldByName('Num_Risp_Esatte').Value + 1;
    numRispErrate := qDomanda.FieldByName('Num_Risp_Err').Value;
    ParamByName('numRispEsatte').Value := numRispEsatte;
    ParamByName('numRispErr').Value := numRispErrate;
    ParamByName('capitolo').Value := capitoli[currentIndex];
    ParamByName('numeroDomanda').Value := domande[currentIndex];
    ExecSQL;
    ShowMessage('Risposta Esatta');
    esatte[currentIndex] := true;
  end; // with

  Inc(esatteCont);
end; // DataRispostaEsatta()

(*
*)
procedure TfDomanda.DataRispostaErrata;
var
  numRispEsatte: integer;
  numRispErrate: integer;
begin
  with uDomanda do begin
    numRispEsatte := qDomanda.FieldByName('Num_Risp_Esatte').Value;
    numRispErrate := qDomanda.FieldByName('Num_Risp_Err').Value + 1;
    ParamByName('numRispEsatte').Value := numRispEsatte;
    ParamByName('numRispErr').Value := numRispErrate;
    ParamByName('capitolo').Value := capitoli[currentIndex];
    ParamByName('numeroDomanda').Value := domande[currentIndex];
    ExecSQL;
    MessageDlg('Risposta Errata!',mtError, [mbOK], 0);
    esatte[currentIndex] := false;
  end; // with

end; // DataRispostaErrata()

(*
*)
procedure TfDomanda.FineQuiz;
var
  i: byte;
  risposteDateEsatte: byte;
  percentualeEsatte: byte;
begin
  Timer1.Enabled := false;
  risposteDateEsatte := 0;
  for i := 0 to numDomande-1 do
    if esatte[i] then Inc(risposteDateEsatte);
  percentualeEsatte :=  Trunc(risposteDateEsatte / numDomande * 100);
  ShowMessage( 'Hai dato '+ IntToStr(risposteDateEsatte) +
              ' risposte esatte su '+ IntToStr(numDomande) +
              ' ('+ IntToStr(percentualeEsatte) +'%)');
  Close;
end; // FineQuiz()

(*
*)
function TfDomanda.IfNull(const Value, Default: OleVariant ): OleVariant;
begin
  if Value = NULL then
    Result := Default
  else
    Result := Value;
end; // IfNull()

(*
*)
function TfDomanda.SecsToHmsStr(ASecs: integer): string;
begin
  Result := Format('%2d:%2.2d:%2.2d',
    [ASecs div 3600, ASecs mod 3600 div 60, ASecs mod 3600 mod 60]);
end; // SecsToHmsStr()

(*
*)
procedure TfDomanda.Timer1Timer(Sender: TObject);
  var TimeOut: TDateTime;
begin
  Dec(tempoConcesso);
  TimeOut := IncSecond(Now, tempoConcesso);
  lbTimer.Caption := 'Tempo Rimasto '+ SecsToHmsStr(SecondsBetween(Now, TimeOut));
  if tempoConcesso <=0 then FineQuiz;
end;

end. // class
