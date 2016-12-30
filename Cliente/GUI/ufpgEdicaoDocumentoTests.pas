unit ufpgEdicaoDocumentoTests;

interface

uses
  ufpgEdicaoDocumento, ufpgGUITestCase, ufpgEdicaoDocumentoModelTests,
  ufpgDataModelTests, FutureWindows, uspGridFiltro;

type
  TffpgEdicaoDocumentoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgEdicaoDocumento;
    FoDados: TfpgEdicaoDocumentoModelTests;
    procedure EmitirDocumento;
    procedure EnterTextIntoCampoDinamico(psNomeCampo, psValor: string);
    procedure SetDynamicFields;
    procedure SelecionarZona;
    procedure SelecionarTipoParte(pbMultiSel: boolean);
    procedure RealizarReservaValores;
    procedure VerificarConsultaEndAr;
    procedure SelecionarPessoa;
    procedure Confirmar;
    procedure Editar;
    procedure PegarTelaEndDest(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarEmitirDocumento;
  end;

type
  TspGridFiltroCrack = class(TspGridFiltro);

implementation

uses
  TestFramework, ufpgCadProcessoTests, ufpgVinculacaoGuiasRecolMandBasico, Forms,
  uggpAgenteCons, usajConstante, ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes,
  ufpgConstanteGUITests, ufpgEditor, uspSendKeys, uedtSelecaoCeritificadoDigital,
  uspInterface, uspCampoMascara, DB, Controls, uedtDocumentoEDT, SysUtils,
  Windows, ufpgCadDestinatarioAr, ufpgEdicaoDocumentoAutomatico;

{ TffpgEdicaoDocumentoTests }

function TffpgEdicaoDocumentoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TfpgEdicaoDocumentoModelTests;
end;

procedure TffpgEdicaoDocumentoTests.EmitirDocumento;
begin
  FoDados := TfpgEdicaoDocumentoModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
  if FoDados.fpgEdicaoDocumentoAutomatico then
  begin

    spTela := PegarTela('ffpgEdicaoDocumentoAutomatico');
    FoDados.fpgNuProcesso := STRING_INDEFINIDO;
  end
  else
    spTela := PegarTela('ffpgEdicaoDocumento');

  FoTela := TffpgEdicaoDocumento(spTela);

  if not FoDados.fpgEstaPreenchido then
  begin
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Nenhum Processo Informado');


    if FoTela.edtCategoriaCons.dfCodigo.PegaTexto = STRING_INDEFINIDO then
      EnterTextInto(FoTela.edtCategoriaCons.dfCodigo, FoDados.fpgCategoria);

    if FoDados.fpgModelo = STRING_INDEFINIDO then
      EnterTextInto(FoTela.edtModeloCons.dfCodigo, gsNuModeloDocumento)
    else
    begin
      //    if gsCliente = CS_CLIENTE_PG5_TJSP then
      //      spVerificadorTelas.RegistrarMensagem('Ocorrência não encontrada. (Modelo)', 'OK');

      EnterTextInto(FoTela.edtModeloCons.dfCodigo, FoDados.fpgModelo);
      sleep(500);
      application.ProcessMessages;
      if FoTela.edtModeloCons.EstaNulo then
      begin

        FoTela.edtModeloCons.Limpe;
        FoTela.edtModeloCons.dfCodigo.DefineTexto(FoDados.fpgModelo);
        Tab;
      end;
    end;

    TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;

    if FoDados.fpgPreencheProcessoNoCompMandado then
      EnterTextInto(FoTela.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
        FoDados.fpgNuProcesso, False)
    else
      EnterTextInto(FoTela.sajProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  end;

  SetDynamicFields;

  if FoDados.fpgSelecionarPessoas then
    SelecionarPessoa;

  if Fodados.fpgVerificarConsultaEndAr then
  begin
    VerificarConsultaEndAr;
    exit;
  end;

  FoTela.pcParametrosIntercalacao.ActivePageIndex := 5;
  FoTela.pcParametrosIntercalacaoChange(FoTela.pcParametrosIntercalacao);
  EnterTextInto(FoTela.spgClassifMandCons.dfCodigo, FoDados.fpgClassificacaoMandado);

  if FoDados.fpgReservaValores then
  begin
    FoTela.pbReservaValor.Click;
    RealizarReservaValores;
  end;

  Confirmar;
  Editar;

  FoDados.fpgNuProcesso := STRING_INDEFINIDO;

  if FoDados.fpgFecharTela then
    FecharTela;
  checkTrue(FoDados.VerificarDocEmitido(gsCdProcesso, gsNuDocumento));
end;

procedure TffpgEdicaoDocumentoTests.TestarEmitirDocumento;
begin
  ExecutarRoteiroTestes(EmitirDocumento);
end;

procedure TffpgEdicaoDocumentoTests.SelecionarTipoParte(pbMultiSel: boolean);
begin
  FoTela.pcParametrosIntercalacao.ActivePage := FoTela.tsPartesDestinatarias;

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

procedure TffpgEdicaoDocumentoTests.EnterTextIntoCampoDinamico(psNomeCampo, psValor: string);
var
  i: integer;
  oCampo: TspCampoMascara;
  oAgenteCons: TggpAgenteCons;
begin
  if psValor <> STRING_INDEFINIDO then
  begin
    for i := 0 to FoTela.scbDados.ComponentCount - 1 do
    begin
      if (FoTela.scbDados.Components[i] is TspCampoMascara) then
      begin
        if TspCampoMascara(FoTela.scbDados.Components[i]).DataField = psNomeCampo then
        begin
          oCampo := TspCampoMascara(FoTela.scbDados.Components[i]);
          if not (oCampo.DataSource.DataSet.State in dsEditModes) then
            oCampo.DataSource.DataSet.Edit;
          CheckFalse(oCampo.ReadOnly);
          Check(oCampo.Visible);
          oCampo.DataSource.DataSet.FieldByName(psNomeCampo).AsString := psValor;
          Break;
        end;
      end
      else
      if (FoTela.scbDados.Components[i] is TggpAgenteCons) then
      begin
        oAgenteCons := TggpAgenteCons(FoTela.scbDados.Components[i]);
        if Pos(psNomeCampo, oAgenteCons.lbRotulo.Caption) > 0 then
        begin
          EnterTextInto(oAgenteCons.dfcdAgente, psValor, False);
        end;
      end;
    end;
  end;
end;

procedure TffpgEdicaoDocumentoTests.Confirmar;
begin
  FoTela.dxbbBotoesSalvar.Click;
end;

procedure TffpgEdicaoDocumentoTests.Editar;
begin
  FoTela.dxbbBotoesSelecionar.click;
end;

procedure TffpgEdicaoDocumentoTests.SelecionarZona;
var
  sDeZona: string;
begin
  if FoTela.espgZona.Active then
  begin
    if FoTela.espgZona.Locate('CDZONA', FoDados.fpgCdZona, []) then
    begin
      sDeZona := FoTela.espgZona.FieldByName('DEZONA').AsString;
      FoTela.SelecionarZona(sDeZona);
    end;
  end;
end;

procedure TffpgEdicaoDocumentoTests.SetDynamicFields;
begin
  EnterTextIntoCampoDinamico('PRAZO_EDITAL', FoDados.fpgPrazoEdital);
  EnterTextIntoCampoDinamico('PRAZO_ATO', FoDados.fpgPrazoAto);
  EnterTextIntoCampoDinamico('QTD_PUBLICAÇÕES', FoDados.fpgQtdPulic);
  EnterTextIntoCampoDinamico('Juiz :', FoDados.fpgJuiz);
  EnterTextIntoCampoDinamico('Escrivão :', FoDados.fpgEscrivao);
  EnterTextIntoCampoDinamico('Agente :', FoDados.fpgAgente);
end;

procedure TffpgEdicaoDocumentoTests.RealizarReservaValores;
var
  oTelaReservaValor: TffpgVinculacaoGuiasRecolMandBasico;
begin
  oTelaReservaValor := PegarTela('ffpgVinculacaoGuiasRecolMandBasico') as
    TffpgVinculacaoGuiasRecolMandBasico;
  EnviarTeclas(oTelaReservaValor.tvRecolhimentos, '({end})');
  oTelaReservaValor.pbVincular.Click;
  oTelaReservaValor.spBotoesCadastroConfirmar.spControleCadastro.Execute(acSalvar);
end;

procedure TffpgEdicaoDocumentoTests.SelecionarPessoa;
var
  sTexto: string;
  bBoleano: boolean;
begin
  FoTela.pcParametrosIntercalacao.ActivePageIndex := 1;
  //  FoTela.pcParametrosIntercalacaoChange(FoTela.pcParametrosIntercalacao);

  SelecionarTipoParte(False);

  if FoDados.fpgCdFormaPagto <> STRING_INDEFINIDO then
  begin
    FoTela.cdsFormaPagamento.locate('CDFORMAPGTO', FoDados.fpgCdFormaPagto, []);
    gsDeFormaPgto := FoDados.fpgDeFormaPagto;
    FoTela.CloseUpColunaPagamento(FoTela.gdPartes, sTexto, bBoleano);

    if FoDados.fpgCdFormaPagto = CS_COM_DILIGENCIA then
      spVerificadorTelas.RegistrarMensagem(
        'Existe mandado em elaboração com forma de pagamento*', 'Não');
  end;

  if FoDados.fpgDeZona <> STRING_INDEFINIDO then
    SelecionarZona;
end;

procedure TffpgEdicaoDocumentoTests.VerificarConsultaEndAr;
begin
  FoTela.pcParametrosIntercalacao.ActivePage := FoTela.tsPartesDestinatarias;

  TFutureWindows.Expect('TffpgCadDestinatarioAr').ExecProc(PegarTelaEndDest);
  FoTela.btDestinatarioAr.Click;
end;

procedure TffpgEdicaoDocumentoTests.PegarTelaEndDest(const poWindow: IWindow);
var
  oTelaDestAR: TffpgCadDestinatarioAr;
begin

  oTelaDestAR := (poWindow.asControl) as TffpgCadDestinatarioAr;

  PosicionarPonteiroMouse(oTelaDestAR.efEncolheFiltro);
  CliqueEsquerdoMouse;

  Application.ProcessMessages;
  sleep(500);

  checkFalse(TspGridFiltroCrack(oTelaDestAR.grFiltro).RowCount > 2, 'Linha da consulta duplicada');
  oTelaDestAR.ccCadastro.Execute(acFecharForm);
end;

end.

