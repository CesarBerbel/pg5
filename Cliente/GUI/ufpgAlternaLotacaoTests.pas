unit ufpgAlternaLotacaoTests;

interface

uses
  ufpgAlternaLotacao, ufpgGUITestCase, ufpgAlternaLotacaoModelTests, ufpgDataModelTests;


type
  TffpgAlternaLotacaoTests = class(TfpgGUITestCase)
  private
    FoTela: TfpgAlternaLotacao;
    FoDados: TffpgAlternaLotacaoModelTests;
    procedure AlternarLotacao;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarAlternarLotacao;
  end;

implementation

uses
  Windows, Forms, uspInterface, SysUtils, ufpgConstanteGUITests, ufpgFuncoesGUITestes,
  ufpgFundoMenu;

procedure TffpgAlternaLotacaoTests.AlternarLotacao;
begin
  FoDados := TffpgAlternaLotacaoModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('fpgAlternaLotacao');

  FoTela := TfpgAlternaLotacao(spTela);

  Check((FoDados.fpgLotacaoAlternada <> ''),
    'Insira os dados na planilha para alterar a lotação.');

  FoTela.grFiltro.spEncolhida := False;
  EnterTextGrid(FoTela.grFiltro, FoDados.fpgLotacaoAlternada, 0);

  Sleep(1500);

  Application.ProcessMessages;

  FoTela.ccCadastro.Execute(acSelecionar);

  Application.ProcessMessages;

  Check((Trim(Copy(ffpgFundoMenu.lbLotacao.Caption, 1, Pos('/', ffpgFundoMenu.lbLotacao.Caption) -
    1)) = Trim(FoDados.fpgLotacaoAlternada)), 'Não foi alterada a lotação.');
end;

function TffpgAlternaLotacaoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgAlternaLotacaoModelTests;
end;

procedure TffpgAlternaLotacaoTests.TestarAlternarLotacao;
begin
  ExecutarRoteiroTestes(AlternarLotacao);
end;

procedure TffpgAlternaLotacaoTests.TearDown;
begin
  //  FecharTela;
  inherited;
end;

procedure TffpgAlternaLotacaoTests.SetUp;
begin
  spNomeTela := 'fpgAlternaLotacao';
  inherited;
end;

end.

