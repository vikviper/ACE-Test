unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, fDomande;

type
  TfMain = class(TForm)
    bt50casuali: TButton;
    bt25Casuali: TButton;
    bt20Casuali: TButton;
    btNCasuali: TButton;
    btCapitolo: TButton;
    teCapitolo: TEdit;
    teNDomande: TEdit;
    btTutte: TButton;
    procedure btCapitoloClick(Sender: TObject);
    procedure bt50CasualiClick(Sender: TObject);
    procedure bt25CasualiClick(Sender: TObject);
    procedure bt20CasualiClick(Sender: TObject);
    procedure btNCasualiClick(Sender: TObject);
    procedure btTutteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;
  fDomanda: TfDomanda;

implementation

{$R *.dfm}

procedure TfMain.bt50CasualiClick(Sender: TObject);
begin
  fDomanda := TfDomanda.Create(self);
  with fDomanda do begin
    capitolo := 0;
    numDomande := 50;
    casuali := true;
    tutte := false;
    tempoConcesso := 7200;
    showModal;
  end;
end;

procedure TfMain.bt25CasualiClick(Sender: TObject);
begin
  fDomanda := TfDomanda.Create(self);
  with fDomanda do begin
    capitolo := 0;
    numDomande := 25;
    casuali := true;
    tutte := false;
    tempoConcesso := 3600;
    showModal;
  end;
end;

procedure TfMain.bt20CasualiClick(Sender: TObject);
begin
  fDomanda := TfDomanda.Create(self);
  with fDomanda do begin
    capitolo := 0;
    numDomande := 25;
    casuali := true;
    tutte := false;
    tempoConcesso := 2880;
    showModal;
  end;
end;

procedure TfMain.btCapitoloClick(Sender: TObject);
begin
  fDomanda := TfDomanda.Create(self);
  with fDomanda do begin
    capitolo := StrToInt(teCapitolo.Text);
    numDomande := 20;
    casuali := false;
    tutte := false;
    tempoConcesso := 2880;
    showModal;
  end;
end;

procedure TfMain.btNCasualiClick(Sender: TObject);
  var
    nDomande: byte;
begin
  fDomanda := TfDomanda.Create(self);
  nDomande := StrToInt(teNDomande.Text);
  with fDomanda do begin
    capitolo := 0;
    numDomande := nDomande;
    casuali := true;
    tutte := false;
    tempoConcesso := nDomande * 144;
    showModal;
  end;
end;

procedure TfMain.btTutteClick(Sender: TObject);
begin
  fDomanda := TfDomanda.Create(self);
  with fDomanda do begin
    capitolo := 0;
    numDomande := 361;
    casuali := false;
    tutte := true;
    tempoConcesso := 10800;
    showModal;
  end;
end;

end.
