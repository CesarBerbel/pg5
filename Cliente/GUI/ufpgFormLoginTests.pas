unit ufpgFormLoginTests;

interface

uses
  ufpgGuiTestCase, ufpgDataModelTests, ufpgFormLogin, ufpgFormLoginModelTests, FutureWindows, ufpgMenu;

type
  TffpgMenuCrack = class(TffpgMenu);

  TffpgFormLoginTests = class(TfpgGuiTestCase)
  private
    FoTela: TffpgFormLogin;
    FoDados: TffpgFormLoginModelTests;
    procedure FormLogin;
    procedure PreencherLogin(const poWindow: IWindow);
    procedure ValidarUsuarioErrado;
    procedure ValidarSenhaErrada;
    procedure ValidarUsuarioCerto;
  public
    procedure TearDown; override;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarFormLogin;
  end;

implementation

uses
  Forms, TestFramework, usajFundoMenu, windows, SysUtils;

const
  CS_USUARIO_ERRADO = 'UsuarioErrado';
  CS_SENHA_ERRADA = 'SenhaErrada';

{ TffpgFormLoginTests }

function TffpgFormLoginTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgFormLoginModelTests;
end;

procedure TffpgFormLoginTests.TestarFormLogin;
begin
  ExecutarRoteiroTestes(FormLogin);
end;

procedure TffpgFormLoginTests.FormLogin;
begin
  FoDados := spDataModelTests as TffpgFormLoginModelTests;

  TFutureWindows.Expect('TffpgFormLogin').ExecProc(PreencherLogin);
  TffpgMenu(spTelaMenu).spSpeedButton1.Click;
end;

procedure TffpgFormLoginTests.PreencherLogin(const poWindow: IWindow);
begin
  FoTela := poWindow.asControl as TffpgFormLogin;

  ValidarUsuarioErrado;

  ValidarSenhaErrada;

  checkTrue(Assigned(FoTela), 'O usuário ' + FoDados.fpgUsuarioCerto +
    ' realizou login no sistema com a senha ' + CS_SENHA_ERRADA + ' que esta errada');

  ValidarUsuarioCerto;
//
//  sleep(500);
end;

procedure TffpgFormLoginTests.ValidarUsuarioErrado;
begin
  spVerificadorTelas.RegistrarMensagem('O usuário*', 'OK');
  FoTela.dfcdUsuarioUS.DefineTexto(CS_USUARIO_ERRADO);
  Tab;
end;

procedure TffpgFormLoginTests.ValidarSenhaErrada;
begin
  FoTela.dfcdUsuarioUS.DefineTexto(FoDados.fpgUsuarioCerto);
  Tab;
  spVerificadorTelas.RegistrarMensagem(
    'O nome do usuário ou a senha fornecida estão incorretos.*', 'OK');
  FoTela.dfnmSenhaUS.DefineTexto(CS_SENHA_ERRADA);
  Tab;
  Click(FoTela.pbOk);
end;

procedure TffpgFormLoginTests.ValidarUsuarioCerto;
begin
  FoTela.dfcdUsuarioUS.DefineTexto(spUsuario);
  Tab;
  FoTela.dfnmSenhaUS.DefineTexto(spSenha);
  Tab;
  Click(FoTela.pbOk);
end;

procedure TffpgFormLoginTests.TearDown;
var
  sCaption: string;
begin
  sCaption := TsajFundoMenu(TffpgMenu(spTelaMenu).spFundoMenu).lbNomeUsuario.Caption;
  check(pos(spUsuario, UpperCase(sCaption)) <> 0, 'O usuário logado é o com a senha errada');
  inherited;
end;

end.

