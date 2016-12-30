unit ufpgCadMandadoExcepcionalTests;

interface

uses
  ufpgCadMandadoExcepcional, ufpgGUITestCase, ufpgCadMandadoExcepcionalModelTests,
  ufpgDataModelTests;

type
  TffpgCadMandadoExcepcionalTests = class(TfpgGUITestCase)
  private
    procedure SelecionarTipoParte(pbMultiSel: boolean);
    procedure PreencherDadosMandado;
    procedure EmissaoMandadoExcepcional;
  public
    FoTela: TffpgCadMandadoExcepcional;
    FoDados: TffpgCadMandadoExcepcionalModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarEmissaodeMandadoExcepcional;
  end;

implementation

uses
  Forms, FutureWindows, SysUtils, uspInterface, TestFramework, ufpgFuncoesGUITestes,
  usajAssistente, ufpgVariaveisTestesGUI, usajConstante;

{ TffpgCadMandadoExcepcionalTests }

function TffpgCadMandadoExcepcionalTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadMandadoExcepcionalModelTests;
end;

procedure TffpgCadMandadoExcepcionalTests.TestarEmissaodeMandadoExcepcional;
begin
  ExecutarRoteiroTestes(EmissaoMandadoExcepcional);
end;

procedure TffpgCadMandadoExcepcionalTests.EmissaoMandadoExcepcional;
begin
  AbrirTela;
  FoTela := TffpgCadMandadoExcepcional(spTela);
  FoDados := TffpgCadMandadoExcepcionalModelTests(spDataModelTests);

  EnterTextInto(FoTela.edtModeloCons.dfCodigo, FoDados.fpgCdModelo, False);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.sajProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  SelecionarTipoParte(False);

  PreencherDadosMandado;

  spVerificadorTelas.RegistrarMensagem('O Mandado Excepcional foi cadastrado com sucesso.*', 'OK');

  FoTela.ccPai.Execute(acSalvar);

  check(FoDados.VerificarMandadoCriado(FoDados.fpgCdModelo, FoDados.fpgNuProcesso) =
    SomenteNumeros(FoTela.dfcdMandado.pegatexto), 'O mandado excepcional ' + ' não foi emitido');

  FoTela.ccPai.Execute(acLimpar);

  FecharTela;
end;

procedure TffpgCadMandadoExcepcionalTests.SelecionarTipoParte(pbMultiSel: boolean);
begin
  Fotela.pcParametrosIntercalacao.ActivePage := FoTela.tsPartesDestinatarias;
  Fotela.pcParametrosIntercalacaoChange(Fotela.pcParametrosIntercalacao);

  if Assigned(FoTela.gdPartes.DataSource.DataSet) and
    (FoTela.gdPartes.DataSource.DataSet.Active) then
  begin
    FoTela.gdPartes.DataSource.DataSet.First;
    while not FoTela.gdPartes.DataSource.DataSet.EOF do
    begin
      if (FoTela.gdPartes.DataSource.DataSet.FieldByName('Tipo').AsString =
        FoDados.fpgTipoParte) then
      begin
        EnterTextGrid(FoTela.gdPartes, 'S', 0);
        if not pbMultiSel then
          Break;
      end;
      FoTela.gdPartes.DataSource.DataSet.Next;
    end;
  end;

end;


procedure TffpgCadMandadoExcepcionalTests.PreencherDadosMandado;
begin
  Fotela.pcParametrosIntercalacao.ActivePage := FoTela.tbsMandados;
  Fotela.pcParametrosIntercalacaoChange(Fotela.pcParametrosIntercalacao);
  EnterTextInto(FoTela.spgClassifMandCons.dfCodigo, FoDados.fpgClassificacao, False);
end;

end.

