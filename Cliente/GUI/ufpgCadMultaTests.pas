unit ufpgCadMultaTests;

interface

uses
  ufpgCadMulta, ufpgGUITestCase, ufpgCadMultaModelTests, ufpgDataModelTests,
  TestFrameWork, Windows, Forms, uspInterface, ufpgFuncoesGUITestes, usajConstante, SysUtils;

type
  TffpgCadMultaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadMulta;
    FoDados: TffpgCadMultaModelTests;
    procedure CadMulta;
    procedure PreencherCadastroMulta;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadMulta;
  end;

implementation

{ TffpgCadMultaTests }

procedure TffpgCadMultaTests.CadMulta;
begin
  AbrirTela;
  FoTela := TffpgCadMulta(spTela);
  FoDados := TffpgCadMultaModelTests(spDataModelTests);

  PreencherCadastroMulta;

  FoTela.ccPai.Execute(acSalvar);

  FecharTela;
  Check(FoDados.VerificarParcelaMulta(FoDados.fpgNuProcesso, FoDados.fpgQtdParcelas),
    'A cadastro das parcelas da multa não foi cadastrada corretamente.');
end;

function TffpgCadMultaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadMultaModelTests;
end;

procedure TffpgCadMultaTests.PreencherCadastroMulta;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  EnterTextInto(FoTela.faipFrmProcessoParte.dfnuProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso);
  MudarAba(FoTela.pcPastaCadastro, '&Parcelas');
  EnterTextInto(FoTela.dfQtdParcelas, FoDados.fpgQtdParcelas);
  EnterTextInto(FoTela.dfVencimento, DateToStr(Now));
  FoTela.dfVencimentoExit(FoTela);
end;

procedure TffpgCadMultaTests.TestarCadMulta;
begin
  ExecutarRoteiroTestes(CadMulta);
end;

end.

