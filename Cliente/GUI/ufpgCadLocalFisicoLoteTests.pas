unit ufpgCadLocalFisicoLoteTests;

interface

uses
  ufpgCadLocalFisicoLote, ufpgGUITestCase, ufpgCadLocalFisicoLoteModelTests, ufpgDataModelTests;

type
  TffpgCadLocalFisicoLoteTests = class(TfpgGUITestCase)
  private
    procedure CadastroLocalFisicoLote;
  public
    FoTela: TffpgCadLocalFisicoLote;
    FoDados: TffpgCadLocalFisicoLoteModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroLocalFisicoLote;
  end;

implementation

uses
  TestFrameWork, Forms, FutureWindows, SysUtils, uspInterface, usajAssistente;

procedure TffpgCadLocalFisicoLoteTests.CadastroLocalFisicoLote;
var
  nRegistros, i: integer;
begin
  AbrirTela;
  FoTela := TffpgCadLocalFisicoLote(spTela);
  FoDados := TffpgCadLocalFisicoLoteModelTests(spDataModelTests);

  if FoTela.csCartorio.Enabled then
    EnterTextInto(FoTela.csCartorio.dfcdCartorio, FoDados.fpgCdCartorio);

  EnterTextInto(FoTela.csLocalFisico.dfcdLocalFisico, FoDados.fpgCdLocalFisico);
  FoTela.dfComplemento.Lines.Add(FoDados.fpgComplemento);

  for i := 0 to StrToInt(FoDados.fpgQtdProcesso) - 1 do
  begin
    TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno,
      FoDados.RetornarProcesso(FoDados.fpgCdForo), False);
    Tab;
    Application.ProcessMessages;
  end;

  nRegistros := FoTela.grDados.DataSource.DataSet.RecordCount;
  FoTela.ccCadastro.Execute(acSalvar);
  FecharTela;
  CheckTrue(nRegistros > 0, 'Não foi localizado processos físicos em Lote');
end;

function TffpgCadLocalFisicoLoteTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadLocalFisicoLoteModelTests;
end;

procedure TffpgCadLocalFisicoLoteTests.TestarCadastroLocalFisicoLote;
begin
  ExecutarRoteiroTestes(CadastroLocalFisicoLote);
end;

end.

