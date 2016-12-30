unit ufpgCadGuiaTests;

interface

uses
  ufpgGUITestCase, ufpgCadGuia, ufpgCadGuiaModelTests, ufpgDataModelTests;

type
  TffpgCadGuiaTests = class(TfpgGUITestCase)
  private
    procedure PreencherDados;
  public
    FoTela: TffpgCadGuia;
    FoDados: TffpgCadGuiaModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure CadastrarGuia;
  published
    procedure TestarCadastrarGuia;
  end;

implementation

{ TffpgCadGuiaTests }

uses
  TestFramework, uspInterface, ufpgVariaveisTestesGUI, usajConstante, ufpgFuncoesGUITestes;

function TffpgCadGuiaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadGuiaModelTests;
end;

procedure TffpgCadGuiaTests.TestarCadastrarGuia;
begin
  ExecutarRoteiroTestes(CadastrarGuia);
end;

procedure TffpgCadGuiaTests.CadastrarGuia;
begin
  AbrirTela;
  FoTela := TffpgCadGuia(spTela);
  FoDados := TffpgCadGuiaModelTests(spDataModelTests);

  PreencherDados;

  Fotela.ccCadastro.Execute(acSalvar);
  FoDados.fpgNuProcesso := STRING_INDEFINIDO;
  FecharTela;
end;

procedure TffpgCadGuiaTests.PreencherDados;
var
  nGRJ: string;
begin
  //Sempre deixar a possibilidade de passar um processo fixo na planilha no caso de ter que fazer
  //algum tipo de auditoria
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;

  checkFalse(FoDados.fpgNuProcesso = STRING_INDEFINIDO, 'Nenhum Processo Informado');

  EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  //Sempre deixar a possibilidade de passar o mandado fixo na planilha no caso de ter que fazer
  //algum tipo de auditoria
  if FoDados.fpgNuMandado = STRING_INDEFINIDO then
    EnterTextInto(FoTela.smdNumeroMandado.dfnuMandado, gsNuMandado, False)
  else
    EnterTextInto(FoTela.smdNumeroMandado.dfnuMandado, FoDados.fpgNuMandado, False);

  EnterTextInto(FoTela.smdNumeroMandado.dfnuSeqMandPrisao, FoDados.fpgNuMandandoPrisao, False);

  Fotela.ccCadastro.Execute(acNovo);

//  nGRJ := copy(gsNuGRJ, Length(gsNuGRJ) - 6, Length(gsNuGRJ) - 1);

  //Sempre deixar a possibilidade de passar o número da GRJ fixo na planilha no caso de ter que fazer
  //algum tipo de auditoria
  if FoDados.fpgNuGuia = STRING_INDEFINIDO then
    EnterTextGrid(FoTela.grDados, nGRJ, 2)
  else
    EnterTextGrid(FoTela.grDados, FoDados.fpgNuGuia, 2);

  EnterTextGrid(FoTela.grDados, FoDados.fpgValorAjudaCusto, 4);

end;

end.

