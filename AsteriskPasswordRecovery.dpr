program AsteriskPasswordRecovery;

uses
  Forms,
  main_form_f in 'main_form_f.pas' {main_form};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Asterisk Password Recovery XP 0.1';
  Application.CreateForm(Tmain_form, main_form);
  Application.Run;
end.
