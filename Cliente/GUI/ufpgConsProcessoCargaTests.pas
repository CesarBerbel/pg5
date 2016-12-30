unit ufpgConsProcessoCargaTests;

interface

uses
  ufpgConsProcessoCargaModelTests, ufpgGUITestCase, ufpgConsProcessoCarga, ufpgDataModelTests;

type
  TffpgConsProcessoCargaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsProcessoCarga;
    FoDados: TffpgConsProcessoCargaModelTests;
    procedure ConsProcessoCarga;
    procedure PreencherDadosConsulta;
    procedure VerificarResultado;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsProcessoCarga;
  end;

implementation

uses
  SysUtils, TestFramework, uspInterface, usajConstante, ufpgFuncoesGUITestes, Forms,
  ucgoRelProcessoCarga;

procedure TffpgConsProcessoCargaTests.ConsProcessoCarga;
begin
  AbrirTela;
  FoTela := TffpgConsProcessoCarga(spTela);
  FoDados := TffpgConsProcessoCargaModelTests(spDataModelTests);
  PreencherDadosConsulta;
  FoTela.ccCadastro.Execute(acConsultar);
  Application.ProcessMessages;
  VerificarResultado;
end;

procedure TffpgConsProcessoCargaTests.PreencherDadosConsulta;
begin
  EnterTextInto(FoTela.cgoLocalizacao.csTipoLocalDestino.dfCdTipoLocal,
    FoDados.fpgTipoLocalDestino);
  EnterTextInto(FoTela.cgoLocalizacao.csLocalDestino.dfCdLocal, FoDados.fpgLocalDestino);

  if FoDados.fpgNaoRecebidos then
    FoTela.cbObjetosNaoRecebidos.Checked := FoDados.fpgNaoRecebidos
  else
  begin
    if FoDados.fpgDataRecebimentoInicial <> STRING_INDEFINIDO then
      EnterTextInto(FoTela.sajPeriodo.FdfDataInicial, FoDados.fpgDataRecebimentoInicial)
    else
      EnterTextInto(FoTela.sajPeriodo.FdfDataInicial, DateToStr(Now));
    if FoDados.fpgDataRecebimentoFinal <> STRING_INDEFINIDO then
      EnterTextInto(FoTela.sajPeriodo.FdfDataFinal, FoDados.fpgDataRecebimentoFinal)
    else
      EnterTextInto(FoTela.sajPeriodo.FdfDataFinal, DateToStr(Now));

    EnterTextCheckBox(FoTela.cbFiltrarDiasVencidos, FoDados.fpgPreencherDiasAtraso);
    EnterTextInto(FoTela.dfnuDiasVencidos, FoDados.fpgDiasAtraso);
  end;
end;

procedure TffpgConsProcessoCargaTests.VerificarResultado;
var
  oTelaResultado: TfcgoRelProcessoCarga;
  bResultado: boolean;
  sNuProcessoComparar: string;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  oTelaResultado := PegarTela('fcgoRelProcessoCarga') as TfcgoRelProcessoCarga;
  bResultado := False;
  oTelaResultado.grDados.DataSource.DataSet.First;
  while not oTelaResultado.grDados.DataSource.DataSet.EOF do
  begin
    sNuProcessoComparar := SomenteNumeros(oTelaResultado.grDados.DataSource.DataSet.FieldByName(
      'NUPROCESSO').AsString);
    if sNuProcessoComparar = FoDados.fpgNuProcesso then
    begin
      bResultado := True;
      Break;
    end;
    oTelaResultado.grDados.DataSource.DataSet.Next;
  end;
  Check(bResultado, 'O processo cadastrado não foi encontrado na consulta de carga.');
end;

function TffpgConsProcessoCargaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsProcessoCargaModelTests;
end;

procedure TffpgConsProcessoCargaTests.TestarConsProcessoCarga;
begin
  ExecutarRoteiroTestes(ConsProcessoCarga);
end;

end.

