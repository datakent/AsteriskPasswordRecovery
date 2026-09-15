unit main_form_f;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  Tmain_form = class(TForm)
    Timer1: TTimer;
    Memo1: TMemo;
    Panel1: TPanel;
    lblHwnd: TLabel;
    btnInfo: TSpeedButton;
    SaveDialog1: TSaveDialog;
    lblHotkey: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblHotkeyClick(Sender: TObject);
  private
    procedure hotykey(var msg:TMessage); message WM_HOTKEY;
    procedure saveResult;
  public
    { Public declarations }
  end;

var
  main_form: Tmain_form;
  id:integer;
  const id_SnapShot = 79;

implementation

{$R *.DFM}

procedure Tmain_form.Timer1Timer(Sender: TObject);
var
 Hand,Hand2:HWND;
 ppoint:TPoint;
 metin:PChar;
begin
  GetCursorPos(ppoint);
  hand:=WindowFromPoint(ppoint);

  if (hand = 0) or (not IsWindow(hand)) then
  begin
    lblHwnd.Caption := 'Hwnd: ---';
    Exit;
  end;

  PostMessage(hand, EM_SETPASSWORDCHAR, 0, 0 );

  lblHwnd.Caption := 'Hwnd: ' + IntToStr(hand);

  Sleep(1);
  GetMem(metin, 999);

  try
    metin[0]:=#0;
    SendMessage(hand, WM_GETTEXT, 999, integer(metin)); //old: LOCALE_IMEASURE
    Memo1.Text:=metin;
  finally
    Freemem(metin);
  end;
end;

procedure Tmain_form.btnInfoClick(Sender: TObject);
begin
 MessageBox(handle, ''+#13+#10+'https://www.datakent.com', 'About', MB_ICONQUESTION or MB_OK);
end;

procedure Tmain_form.hotykey(var msg: TMessage);
begin
                   //Ctrl                        //O
  if (msg.LParamLo=MOD_CONTROL) and (msg.LParamHi=id_SnapShot) then
     saveResult;
end;

procedure Tmain_form.lblHotkeyClick(Sender: TObject);
begin
   saveResult();
end;

procedure Tmain_form.saveResult;
begin
  Timer1.Enabled := False;

  if SaveDialog1.Execute then
  begin
    Memo1.Lines.Add('');
    Memo1.Lines.Add(lblHwnd.Caption);
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;

  Timer1.Enabled := True;
end;

procedure Tmain_form.FormShow(Sender: TObject);
begin
  RegisterHotKey(handle, id, MOD_CONTROL, id_SnapShot);
end;

procedure Tmain_form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnRegisterHotKey(handle,id_SnapShot);
end;

end.
