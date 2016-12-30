//LUCIANO.FAGUNDES - 20/10/2016
unit ufpgUnificacaoAdvTests;

interface

uses
  ufpgUnificacaoAdv, ufpgGUITestCase, FutureWindows, ufpgUnificacaoAdvModelTests,
  ufpgDataModelTests;

type
  TffpgUnificacaoAdvTests = class(TfpgGUITestCase)
  private
    scdAdv: string;
    snudoc: string;
    FoTela: TffpgUnificacaoAdv;
    FoDados: TffpgUnificacaoAdvModelTests;
    procedure UnificarAdvogados;
    procedure PreencherDados;
    procedure PegarTelaModal(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarUnificacaoAdvogados;
  end;

implementation

uses
  TestFrameWork, Forms, Windows, usajConstante, ufpgFuncoesGUITestes,
  usaj5ConsPessoa, uspInterface;

{ TffpgUnificacaoAdvTests }

function TffpgUnificacaoAdvTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgUnificacaoAdvModelTests;
end;

procedure TffpgUnificacaoAdvTests.TestarUnificacaoAdvogados;
begin
  ExecutarRoteiroTestes(UnificarAdvogados);
end;

procedure TffpgUnificacaoAdvTests.UnificarAdvogados;
begin
  AbrirTela;
  FoTela := TffpgUnificacaoAdv(spTela);
  FoDados := TffpgUnificacaoAdvModelTests(spDataModelTests);

  PreencherDados;
  FoDados.VerificarAdvogadoUnificado(snudoc, scdAdv);
end;

procedure TffpgUnificacaoAdvTests.PreencherDados;
var
  i: integer;
begin

  TFutureWindows.Expect('Tfsaj5ConsPessoa').ExecProc(PegarTelaModal);
  EnterTextInto(FoTela.csPessoa.dfnmPessoa, FoDados.fpgnmAdvogado);

  FoTela.grDados.DataSource.DataSet.First;
  for i := 1 to 2 do
  begin
    FoTela.grDados.DataSource.DataSet.Edit;
    EnterTextGrid(FoTela.grDados, 'S', 0);
    scdAdv := FoTela.grDados.DataSource.DataSet.FieldList.FieldByName('cdPessoa').AsString;
    snudoc := Copy(FoTela.grDados.DataSource.DataSet.FieldList.FieldByName(
      'nuDocFormatado').AsString, 5, 9);
    FoTela.grDados.DataSource.DataSet.Next;
  end;

end;

procedure TffpgUnificacaoAdvTests.PegarTelaModal(const poWindow: IWindow);
var
  oTelaConsPessoa: Tfsaj5ConsPessoa;
begin
  oTelaConsPessoa := poWindow.asControl as Tfsaj5ConsPessoa;
  oTelaConsPessoa.ccCadastro.Execute(acSelecionar);
end;

end.

