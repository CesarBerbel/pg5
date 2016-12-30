unit ufpgCadArmasBensPG5Tests;

interface

uses
  ufpgCadArmasBensPG5, ufpgGUITestCase, ufpgCadArmasBensPG5ModelTests, ufpgDataModelTests;

type
  TffpgCadArmasBensPG5Tests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadArmasBensPG5;
    FoDados: TffpgCadArmasBensPG5ModelTests;
    procedure PreencherArmasBens;
    procedure CadastrarArmasEBens;
    procedure SelecionarStituacaoArmasBens;
    function GerarNumeroRandomico: string;
    function GerarPlaca: string;
    procedure ExcluirArmasBens;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarCadastroDeArmasEBens;
  end;

implementation

uses
  TestFrameWork, ufpgConsSituacaoBem, uspInterface, FutureWindows, SysUtils,
  ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes, usajConstante;

function TffpgCadArmasBensPG5Tests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadArmasBensPG5ModelTests;
end;

procedure TffpgCadArmasBensPG5Tests.CadastrarArmasEBens;
begin
  AbrirTela;
  FoTela := TffpgCadArmasBensPG5(spTela);
  FoDados := TffpgCadArmasBensPG5ModelTests(spDataModelTests);

  if FoDados.fpgExcluir then
  begin
    ExcluirArmasBens;
    Exit;
  end;

  PreencherArmasBens;

  FoTela.ccCadastro.Execute(acSalvar);

  Check(FoDados.RetornarBemCadastrado(FoDados.fpgNuProcesso),
    'O bem não foi cadastrado no processo: ' + FoDados.fpgNuProcesso);
end;

procedure TffpgCadArmasBensPG5Tests.TestarCadastroDeArmasEBens;
begin
  ExecutarRoteiroTestes(CadastrarArmasEBens);
end;

procedure TffpgCadArmasBensPG5Tests.SelecionarStituacaoArmasBens;
var
  oTelaSitBem: TffpgConsSituacaoBem;
begin
  oTelaSitBem := TffpgConsSituacaoBem(PegarTela('ffpgConsSituacaoBem'));
  oTelaSitBem.efpgSituacaoBem.Locate('CDSITUACAOBEM', FoDados.fpgcsSituacaoBem, []);
  oTelaSitBem.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadArmasBensPG5Tests.PreencherArmasBens;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  FoTela.fpgArmasBens.ccBem.Execute(acNovo);

  EnterTextInto(FoTela.fpgArmasBens.csCategoriaBem.dfcdCategoriaBem, FoDados.fpgdfcdCategoriaBem);
  EnterTextInto(FoTela.fpgArmasBens.dfdtEntrada, DateToStr(Now));
  EnterTextInto(FoTela.fpgArmasBens.dfNuControle, FoDados.fpgdfNuControle);
  EnterTextInto(FoTela.fpgArmasBens.dfdtSituacaoBem, DateToStr(Now));
  FoTela.fpgArmasBens.csSituacaoBem.pbConsulta.Click;
  SelecionarStituacaoArmasBens;
  FoTela.fpgArmasBens.dfdtLocalFisico.SetFocus;
  EnterTextInto(FoTela.fpgArmasBens.dfdtLocalFisico, DateToStr(Now));
  EnterTextInto(FoTela.fpgArmasBens.dfdeLocalFisico, FoDados.fpgdfdeLocalFisico);
  EnterTextInto(FoTela.fpgArmasBens.dfnmDepositario, FoDados.fpgdfnmDepositario);

  //*************ARMAS CÓDIGO = 1*************\\
  EnterTextInto(FoTela.fpgArmasBens.dfdeArma, FoDados.fpgdfdeArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeSerieArma, FoDados.fpgdfdeSerieArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCorArma, FoDados.fpgdfdeCorArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeMarcaArma, FoDados.fpgdfdeMarcaArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeDimensaoArma, FoDados.fpgdfdeDimensaoArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCalibreArma, FoDados.fpgdfdeCalibreArma);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCaboArma, FoDados.fpgdfdeCaboArma);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplementoArma, FoDados.fpgmmdeComplementoArma);


  //*************MUNIÇÃO CÓDIGO = 2*************\\
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDados.fpgdeItemBemMunicao, 0);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDados.fpgqtIntactaMunicao, 1);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDados.fpgqtDeflagradaMunicao, 2);
  EnterTextGrid(FoTela.fpgArmasBens.grMunicao, FoDados.fpgdeComplementoMunicao, 3);

  //*************VEÍCULO CÓDIGO = 3*************\\
  if FoDados.fpgdfcdCategoriaBem = '3' then
  begin
    EnterTextInto(FoTela.fpgArmasBens.dfnuRenavan, GerarNumeroRandomico);
    EnterTextInto(FoTela.fpgArmasBens.dfnuPlaca, GerarPlaca);
    EnterTextInto(FoTela.fpgArmasBens.dfnuChassi, GerarNumeroRandomico);
  end;
  EnterTextInto(FoTela.fpgArmasBens.dfdeEspecieTipo, FoDados.fpgdfdeEspecieTipo);
  EnterTextInto(FoTela.fpgArmasBens.dfdeMarcaModelo, FoDados.fpgdfdeMarcaModelo);
  EnterTextInto(FoTela.fpgArmasBens.dfnuAnoFab, FoDados.fpgdfnuAnoFab);
  EnterTextInto(FoTela.fpgArmasBens.dfnuAnoMod, FoDados.fpgdfnuAnoMod);
  EnterTextInto(FoTela.fpgArmasBens.dfdeCor, FoDados.fpgdfdeCor);
  EnterTextInto(FoTela.fpgArmasBens.dfnmProprietario, FoDados.fpgdfnmProprietario);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplemento, FoDados.fpgmmdeComplemento);

  //*************IMÓVEL CÓDIGO = 4*************\\
  if FoDados.fpgdfcdCategoriaBem = '4' then
  begin
    EnterTextInto(FoTela.fpgArmasBens.dfnuRegistro, GerarNumeroRandomico);
    EnterTextInto(FoTela.fpgArmasBens.dfNuMatricula, GerarNumeroRandomico);
  end;
  FoTela.fpgArmasBens.dfdtAvaliacaoImovel.DefineTexto(DateToStr(Now));
  FoTela.fpgArmasBens.dfvlAvaliacaoImovel.DefineTexto(FoDados.fpgdfvlAvaliacaoImovel);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfCEP, FoDados.fpgdfCEP);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.csMunicipio.dfcdMunicipio,
    FoDados.fpgdfcdMunicipio);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfdeBairro, FoDados.fpgdfdeBairro);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfdeLogradouro, FoDados.fpgdfdeLogradouro);
  EnterTextInto(FoTela.fpgArmasBens.sajEndereco.dfNumero, FoDados.fpgdfNumero);
  EnterTextInto(FoTela.fpgArmasBens.mmdeComplemento, FoDados.fpgdfdeComplemento);
  EnterTextInto(FoTela.fpgArmasBens.dfdeImovel, FoDados.fpgdfdeImovel);
  EnterTextRadioGroup(FoTela.fpgArmasBens.rgProprietario, FoDados.fpgrgProprietario);
  EnterTextInto(FoTela.fpgArmasBens.dfNmProprietarioImovel, FoDados.fpgdfNmProprietarioImovel);

  //*************TITULO CÓDIGO = 5*************\\
  EnterTextInto(FoTela.fpgArmasBens.dfdeTitulo, FoDados.fpgDescricaoTitulo);
  EnterTextInto(FoTela.fpgArmasBens.dfqtBemTitulo, FoDados.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.dfVlTitulo, FoDados.fpgdfqtBemTitulo);
  EnterTextInto(FoTela.fpgArmasBens.mmComplTitulo, FoDados.fpgmmdeComplemento);

  //*************OUTRO BEM / OBJETO CÓDIGO = 6*************\\
  if FoDados.fpgdfcdCategoriaBem = '6' then
  begin
    FoTela.fpgArmasBens.efpgItemBem.Edit;
    FoTela.fpgArmasBens.efpgItemBem.FieldByName('DEITEMBEM').AsString := FoDados.fpgdeItemBem;
    FoTela.fpgArmasBens.efpgItemBem.FieldByName('QTINTACTA').AsString := FoDados.fpgqtIntacta;
    FoTela.fpgArmasBens.efpgItemBem.FieldByName('DECOMPLEMENTO').AsString :=
      FoDados.fpgdeComplemento;
  end;
end;

function TffpgCadArmasBensPG5Tests.GerarNumeroRandomico: string;
begin
  Randomize;
  result := IntToStr(Random(99999999) + 1000);
end;

//25/05/2015 - ANTONIO.SOUSA - SALT: 186660/2/4
function TffpgCadArmasBensPG5Tests.GerarPlaca: string;
const
  sPlaca: array[1..26] of string =
    ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
var
  i: integer;
  sLetras: string;
  sNumeros: string;
begin
  Randomize;
  for i := 0 to 2 do
  begin
    sLetras := sLetras + sPlaca[Random(26) + 1];
  end;
  sNumeros := IntToStr(Random(999) + 1000);
  result := sLetras + sNumeros;
end;

procedure TffpgCadArmasBensPG5Tests.TearDown;
begin
  FecharTela;
  inherited;
end;

procedure TffpgCadArmasBensPG5Tests.ExcluirArmasBens;
var
  nArmasBensAntesExcluir: integer;
  nArmasBensDepoisExcluir: integer;
begin
  spVerificadorTelas.RegistrarMensagem('Confirma a exclusão do(a) armas e bens?', 'OK');
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  nArmasBensAntesExcluir := FoTela.fpgArmasBens.tvArmasBens.Items.Count;
  FoTela.fpgArmasBens.ccBem.Execute(acExcluir);
  nArmasBensDepoisExcluir := FoTela.fpgArmasBens.tvArmasBens.Items.Count;
  check(nArmasBensAntesExcluir > nArmasBensDepoisExcluir, 'Arma ou bem não foi excluído.');
  FoTela.ccCadastro.Execute(acSalvar);
end;

end.

