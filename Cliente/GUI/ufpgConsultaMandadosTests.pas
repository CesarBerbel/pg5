unit ufpgConsultaMandadosTests;

interface

uses
  ufpgConsultaMandados, ufpgGUITestCase, ufpgConsultaMandadosModelTests, ufpgDataModelTests;


type
  TffpgConsultaMandadosTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsultaMandados;
    FoDados: TffpgConsultaMandadosModelTests;
    procedure ConsultaAvancadaMandado;
    procedure PreencherDados;
    procedure ValidarDados;
    procedure VerificaResultado;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarConsultaAvancadaMandado;
  end;

implementation

uses
  ufpgVariaveisTestesGUI, usmdResultadoConsulta, usmdSelecionaMandado, FutureWindows,
  SysUtils, uspInterface, WPXMLint, ufpgFuncoesGUITestes, Forms, ufpgConstanteGUITests;

var
  sCdMandado: string;

{ TffpgConsultaMandadosTests }

function TffpgConsultaMandadosTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsultaMandadosModelTests;
end;


procedure TffpgConsultaMandadosTests.ConsultaAvancadaMandado;
begin
  AbrirTela;
  FoTela := TffpgConsultaMandados(spTela);
  FoDados := TffpgConsultaMandadosModelTests(spDataModelTests);

  PreencherDados;

  FoTela.spBotoesCadastro.spControleCadastro.Execute(acConsultar);

  ValidarDados;
  FecharTela;
end;

procedure TffpgConsultaMandadosTests.ValidarDados;
var
  iPosInicio, iPosFim: integer;
  sCentral, sArq, sAgente: string;
  wpxmltr1: TWPXMLTree;
  oXmlDistribuicao: TWPXMLOneLevel;
  oXmlMandado: TWPXMLOneLevel;
begin
  if FoTela.esmdMandado.RecordCount > 1 then
    VerificaResultado;

  if sCdMandado <> '' then
  begin
    wpxmltr1 := TWPXMLTree.Create(FoTela);
    try
      sArq := ExtractFilePath(Application.ExeName) + 'consulta\' + sCdMandado + '.xml';
      check(FileExists(sArq), 'Falha ao abrir xml!');
      wpxmltr1.LoadFromFile(sArq);
      oXmlDistribuicao := wpxmltr1.TagByName('MANDADO').Find('DISTRIBUICOES').Find('DISTRIBUICAO');
      oXmlMandado := wpxmltr1.TagByName('MANDADO').Find('DADOSDOMANDADO');
      Check(SomenteNumeros(oXmlMandado.GetSValue('NUMANDADO')) = gsNuMandado,
        'Erro - Numero de Mandado Invalido ');
      Check(Copy(oXmlMandado.GetSValue('DTCADASTRO'), 1, 10) = Copy(gsDataEmissao, 1, 10),
        'Erro - Data de Emissao Invalida ');
      if gsDeFormaPgto <> '' then
        Check(oXmlMandado.GetSValue('DEFORMAPGTO') = gsDeFormaPgto,
          'Erro - Forma de Pagamento Diferente ');

      if gbMandadoDistribuido then
      begin
        sAgente := oXmlDistribuicao.GetSValue('CDAGENTE');
        Check(sAgente = gsCdAgente, 'Erro - Numero de Agente Invalido ');
        Check(oXmlDistribuicao.GetSValue('CDSITUACAOMAND') = gsSituacaoMandado,
          'Erro-Situacao Invalida ');

        //CENTRAL
        sCentral := oXmlDistribuicao.GetSValue('DECOMPLEMENTO');
        iPosInicio := Pos('Central: ', sCentral) + 9;
        iPosFim := Pos('/ Zona:', sCentral) - 1;
        sCentral := Copy(sCentral, iPosInicio, iPosFim - iPosInicio);
        Check(sCentral = gsCdCentral, 'Erro - Numero da Central Invalido ');
        Check(oXmlMandado.GetSValue('DEZONA') = gsDeZona, 'Erro - Nome da Zona invalida ');
      end;

    finally
      wpxmltr1.Free;
    end;
  end;
end;

procedure TffpgConsultaMandadosTests.VerificaResultado;
var
  oTelaResultado: TfsmdResultadoConsulta;
begin
  oTelaResultado := PegarTela('fsmdResultadoConsulta') as TfsmdResultadoConsulta;
  Check(oTelaResultado.grDados.DataSource.DataSet.Locate('nuMandado', gsNuMandado, []),
    'Erro - Mandado nao encontrado ');
  sCdMandado := oTelaResultado.grDados.DataSource.DataSet.FieldByName('cdMandado').AsString;
  oTelaResultado.pbDados.Click;
end;

procedure TffpgConsultaMandadosTests.PreencherDados;
var
  sDataEmissao, sDataDist: string;
begin
  if FoDados.fpgPesquisarNuProcesso then
  begin
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Mandado não definido');

    EnterTextInto(FoTela.smdNumeroMandadoPesq.sajNumeroProcesso.FdfNumeroProcessoExterno,
      FoDados.fpgNuProcesso, False);
    Application.ProcessMessages;
  end;
  if FoDados.fpgPesquisarNuMandado then
  begin
    if FoDados.fpgNuMandado = STRING_INDEFINIDO then
      if gsNuMandado <> STRING_INDEFINIDO then
        FoDados.fpgNuMandado := gsNuMandado;
    Check(FoDados.fpgNuMandado <> STRING_INDEFINIDO, 'Número de Mandado não definido');

    if FoTela.smdNumeroMandadoPesq.dfnuMandado.PegaTexto <> '' then
      FoDados.fpgNuMandado := Copy(FoDados.fpgNuMandado,
        Length(FoTela.smdNumeroMandadoPesq.dfnuMandado.PegaTexto) + 1,
        Length(FoDados.fpgNuMandado));
    EnterTextInto(FoTela.smdNumeroMandadoPesq.dfnuMandado, FoDados.fpgNuMandado, False);
    Application.ProcessMessages;
  end;
  if FoDados.fpgPesquisarDtEmissao then
  begin
    if gsDataEmissao = '' then
      gsDataEmissao := FormatDateTime('DD/MM/YYYY', Now);
    sDataEmissao := copy(gsDataEmissao, 1, 10);

    EnterTextInto(FoTela.prDataEmissaoPes.FdfDataInicial, sDataEmissao, False);
    EnterTextInto(FoTela.prDataEmissaoPes.FdfDataFinal, sDataEmissao, False);
    Application.ProcessMessages;
  end;
  if FoDados.fpgPesquisarDtDistribuicao then
  begin
    FoTela.pcFiltros.ActivePage := FoTela.tsDistribuicoes;
    sDataDist := FormatDateTime('DD/MM/YYYY', Now);

    EnterTextInto(FoTela.prDataDistribuicoesPesq.FdfDataInicial, sDataDist, False);
    EnterTextInto(FoTela.prDataDistribuicoesPesq.FdfDataFinal, sDataDist, False);
    if FoDados.fpgTipoDistribuicao <> '' then
      EnterTextInto(FoTela.smdTipoDistMandConsPesq.dfCodigo, FoDados.fpgTipoDistribuicao, False);
    Application.ProcessMessages;
  end;
  if FoDados.fpgPesquisarPessoa then
  begin
    FoTela.pcFiltros.ActivePage := FoTela.tsPessoas;

    EnterTextInto(FoTela.sajPessoConsPesq, FoDados.fpgNomePessoa, False);
    Application.ProcessMessages;
  end;
end;

procedure TffpgConsultaMandadosTests.TestarConsultaAvancadaMandado;
begin
  ExecutarRoteiroTestes(ConsultaAvancadaMandado);
end;

end.

