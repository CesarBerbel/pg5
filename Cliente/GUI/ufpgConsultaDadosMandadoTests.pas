unit ufpgConsultaDadosMandadoTests;

interface

uses
  ufpgConsultaDadosMandado, ufpgGUITestCase, ufpgConsultaDadosMandadoModelTests,
  ufpgDataModelTests, FutureWindows;

type
  TffpgConsultaDadosMandadoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsultaDadosMandado;
    FoDados: TffpgConsultaDadosMandadoModelTests;
    procedure ConsultaBasicaMandado;
    procedure PreencherDados;
    procedure ValidarDados;
    procedure PegarTelaSelecionaMandado(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsultaBasicaMandado;
  end;

implementation

uses
  ufpgVariaveisTestesGUI, usmdSelecionaMandado, ufpgFuncoesGUITestes, Forms, SysUtils, uspInterface, ufpgConstanteGUITests;

{ TffpgConsultaDadosMandadoTests }

procedure TffpgConsultaDadosMandadoTests.TestarConsultaBasicaMandado;
begin
  ExecutarRoteiroTestes(ConsultaBasicaMandado);
end;

function TffpgConsultaDadosMandadoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsultaDadosMandadoModelTests;
end;

procedure TffpgConsultaDadosMandadoTests.ConsultaBasicaMandado;
begin
  AbrirTela;
  FoTela := TffpgConsultaDadosMandado(spTela);
  FoDados := TffpgConsultaDadosMandadoModelTests(spDataModelTests);

  PreencherDados;

  ValidarDados;
  FecharTela;
end;

procedure TffpgConsultaDadosMandadoTests.PegarTelaSelecionaMandado(const poWindow: IWindow);
var
  oTelaSelecionaMandado: TfsmdSelecionaMandado;
begin
  oTelaSelecionaMandado := poWindow.asControl as TfsmdSelecionaMandado;
  oTelaSelecionaMandado.grDados.DataSource.DataSet.Locate('nuMandado', FoDados.fpgNuMandado, []);
  oTelaSelecionaMandado.bcBotoesCadastro.spControleCadastro.Execute(acSelecionar);
end;

procedure TffpgConsultaDadosMandadoTests.ValidarDados;
var
  sData1, sData2: string;
  sSituacao: string;
  sCategoria: string;
  sModelo: string;
  bValidou: boolean;
begin
  FoTela.pcDetalhes.ActivePage := FoTela.tbDadosMandado;
  FoTela.pcDetalhesChange(FoTela.pcDetalhes);

  if FoDados.fpgConsultaPorProcesso then
    Check(Pos(FoTela.smdNumeroMandado.smdNumeroProcesso.FdfNumeroProcessoExterno.PegaTexto,
      FoDados.fpgNuProcesso) > 0, 'Falha - Validar Nº Processo')
  else
    Check(FoTela.smdNumeroMandado.dfnuMandado.PegaTexto = FoDados.fpgNuMandado,
      'Falha - Validar Nº Mandado');
  sData1 := copy(FoTela.dfDtEmissao.Text, 1, 10);
  sData2 := copy(gsDataEmissao, 1, 10);
  Check(sData1 = sData2, 'Falha - Validar DtEmissao ');
  sSituacao := FoTela.smdCamposAdicionaisDados.smdSituacaoMandCamposAdicionais.dfCodigo.PegaTexto;
  bValidou := sSituacao = gsSituacaoMandado;
  Check(bValidou, 'Falha - Validar Situacao ');
  FoTela.pcDetalhes.ActivePage := FoTela.tbDocumentosMandado;
  FoTela.pcDetalhesChange(FoTela.pcDetalhes);

  if StrToInt(FoTela.gcNuSeqHist.Field.Text) > 1 then
  begin
    FoTela.dbgHistoricoFluxo.DataSource.DataSet.Edit;
    FoTela.dbgHistoricoFluxo.DataSource.DataSet.Last;
  end;

  sCategoria := FoTela.gcnmCategoria.Field.Text;
  sModelo := FoTela.gcnmModelo.Field.Text;
  Check(sCategoria = gsCategoria, 'Falha - Validar Categoria ');
  Check(sModelo = gsModelo, 'Falha - Validar Modelo ');
  Check(FoTela.fsmdZonaConsDados.PegaTexto = gsZona, 'Falha - Validar Zona ');
end;

procedure TffpgConsultaDadosMandadoTests.PreencherDados;
begin
  if FoDados.fpgConsultaPorProcesso then
  begin
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := usarProcessoArray;
    check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

    TFutureWindows.Expect('TfsmdSelecionaMandado').ExecProc(PegarTelaSelecionaMandado);
    EnterTextInto(FoTela.smdNumeroMandado.smdNumeroProcesso.FdfNumeroProcessoExterno,
      FoDados.fpgNuProcesso, False);
  end
  else
  begin
    if FoDados.fpgNuMandado = STRING_INDEFINIDO then
      FoDados.fpgNuMandado := gsNuMandado;
    check(FoDados.fpgNuMandado <> STRING_INDEFINIDO, 'Número deo mandado não encontrado');

    FoTela.smdNumeroMandado.dfnuMandado.ClearContents;
    EnterTextInto(FoTela.smdNumeroMandado.dfnuMandado, FoDados.fpgNuMandado, False);
  end;
end;

end.

