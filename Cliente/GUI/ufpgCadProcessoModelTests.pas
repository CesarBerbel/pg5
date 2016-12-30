// 22/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadProcessoModelTests;

interface

uses
  ufpgModelTests, ADODB, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, uspClientDataSet;

type
  TffpgCadParteRepresModelTests = class(TfpgModelTests)
  private
    FbEsperaMensagemAdvPoloContrario: boolean;
    FbPreencherPeloCodigoPessoa: boolean;
    FbEnderecoPrincipal: boolean;
    FbGerarNomeParteAleatorio: boolean;
    FsCEP: string;
    FsTipoPessoa: string;
    FsPolo: string;
    FsEstadoCivil: string;
    FsCPF: string;
    FsTipoParticipacao: string;
    FsComplemento: string;
    FsMunicipio: string;
    FsCdPessoa: string;
    FsNacionalidade: string;
    FsNomeParte: string;
    FsProfissao: string;
    FsNumero: string;
    FbNaoClicarBotaoParte: boolean;
    FbNaoClicarBotaoCunsultaParte: boolean;
    FbPossuiEqtaAutuacao: boolean;
    FbcbxIdoso: boolean;
    FbcbxDoencaGrave: boolean;
    FbcbxJusticaGratuita: boolean;
  published
    property fpgNomeParte: string read FsNomeParte write FsNomeParte;
    property fpgPolo: string read FsPolo write FsPolo;
    property fpgTipoParticipacao: string read FsTipoParticipacao write FsTipoParticipacao;
    property fpgTipoPessoa: string read FsTipoPessoa write FsTipoPessoa;
    property fpgCPF: string read FsCPF write FsCPF;
    property fpgNacionalidade: string read FsNacionalidade write FsNacionalidade;
    property fpgEstadoCivil: string read FsEstadoCivil write FsEstadoCivil;
    property fpgProfissao: string read FsProfissao write FsProfissao;
    property fpgComplemento: string read FsComplemento write FsComplemento;
    property fpgEsperaMensagemAdvPoloContrario: boolean   
      read FbEsperaMensagemAdvPoloContrario write FbEsperaMensagemAdvPoloContrario;
    property fpgGerarNomeParteAleatorio: boolean 
      read FbPreencherPeloCodigoPessoa   write FbPreencherPeloCodigoPessoa;
    property fgpPreencherPeloCodigoPessoa: boolean 
      read FbGerarNomeParteAleatorio   write FbGerarNomeParteAleatorio;
    property fpgMunicipio: string read FsMunicipio write FsMunicipio;
    property fpgCEP: string read FsCEP write FsCEP;
    property fpgNumero: string read FsNumero write FsNumero;
    property fpgCdPessoa: string read FsCdPessoa write FsCdPessoa;
    property fpgEnderecoPrincipal: boolean read FbEnderecoPrincipal write FbEnderecoPrincipal;
    property fpgNaoClicarBotaoParte: boolean read FbNaoClicarBotaoParte 
      write FbNaoClicarBotaoParte;
    property fpgNaoClicarBotaoCunsultaParte: boolean   
      read FbNaoClicarBotaoCunsultaParte write FbNaoClicarBotaoCunsultaParte;
    property fpgPossuiEqtaAutuacao: boolean read FbPossuiEqtaAutuacao write FbPossuiEqtaAutuacao;
    property fpgcbxIdoso: boolean read FbcbxIdoso write FbcbxIdoso;
    property fpgcbxDoencaGrave: boolean read FbcbxDoencaGrave write FbcbxDoencaGrave;
    property fpgcbxJusticaGratuita: boolean read FbcbxJusticaGratuita write FbcbxJusticaGratuita;
  end;


  TffpgDelegaciaModelTests = class(TfpgModelTests)
  private
    FsCodDistrito: string;
    FsDataDelito: string;
    FsAutoridade: string;
    FsCodDocumento: string;
    FsNuDocumento: string;

  published
    property fpgCodDistrito: string read FsCodDistrito write FsCodDistrito;
    property fpgDataDelito: string read FsDataDelito write FsDataDelito;
    property fpgAutoridade: string read FsAutoridade write FsAutoridade;
    property fpgCodDocumento: string read FsCodDocumento write FsCodDocumento;
    property fpgNuDocumento: string read FsNuDocumento write FsNuDocumento;
  end;

  TffpgPrecatoriaModelTests = class(TfpgModelTests)
  private
    FsJuizoDeprecante: string;
    FsCdMunicipio: string;
    FsNuOriPrecatoria: string;
  published
    property fpgCdMunicipio: string read FsCdMunicipio write FsCdMunicipio;
    property fpgNuOriPrecatoria: string read FsNuOriPrecatoria write FsNuOriPrecatoria;
    property fpgJuizoDeprecante: string read FsJuizoDeprecante write FsJuizoDeprecante;
  end;

  TffpgObjetoAcaoModelTests = class(TfpgModelTests)
  private
    FsObjetoAcao: string;
  published
    property fpgObjetoAcao: string read FsObjetoAcao write FsObjetoAcao;
  end;

  TffpgOutrosNumerosModelTests = class(TfpgModelTests)
  private
    FsOutroNumero: string;
    FsDescricao: string;
    FsObservacao: string;
  published
    property fpgOutroNumero: string read FsOutroNumero write FsOutroNumero;
    property fpgDescricao: string read FsDescricao write FsDescricao;
    property fpgObservacao: string read FsObservacao write FsObservacao;
  end;

  TffpgAssuntoModelTests = class(TfpgModelTests)
  private
    FsCdAssuntoCompl: string;
    FsFlEtiqueta: string;
    FsCdAssunto: string;
    FsFlPrincipal: string;
  published
    property fpgFlPrincipal: string read FsFlPrincipal write FsFlPrincipal;
    property fpgCdAssunto: string read FsCdAssunto write FsCdAssunto;
    property fpgCdAssuntoCompl: string read FsCdAssuntoCompl write FsCdAssuntoCompl;
    property fpgFlEtiqueta: string read FsFlEtiqueta write FsFlEtiqueta;
  end;


  TffpgCadArmasBensModelTests = class(TfpgModelTests)
  private
    FsdfdeArma: string;
    FsgrMunicao: string;
    FsdfdeCaboArma: string;
    FsdfCEP: string;
    FsdfdeLocalFisico: string;
    FsdfnuAnoFab: string;
    FsdfnuChassi: string;
    FsdfdeMarcaArma: string;
    FsmmdeComplemento: string;
    FsdfnuAnoMod: string;
    FsdfcdMunicipio: string;
    FsmmComplTitulo: string;
    FsdfdeCorArma: string;
    FsdfdeImovel: string;
    FsdfqtBemTitulo: string;
    FsdfdeCalibreArma: string;
    FsqtDeflagradaMunicao: string;
    FsgrOutrosBensObj: string;
    FsmmdeComplementoArma: string;
    FsdfvlAvaliacaoImovel: string;
    FsdfNumero: string;
    FsdeItemBemMunicao: string;
    FsdfdeComplemento: string;
    FsdeItemBem: string;
    FsdfdtEntrada: string;
    FsdfnuRegistro: string;
    FsdfdtSituacaoBem: string;
    FsdfdtAvaliacaoImovel: string;
    FsqtIntacta: string;
    FsdfNmProprietarioImove: string;
    FsdfnuRenavan: string;
    FsdfnuPlaca: string;
    FscsSituacaoBem: string;
    FsdfdeDimensaoArma: string;
    FsdeComplementoMunicao: string;
    FsdfdeSerieArma: string;
    FsqtIntactaMunicao: string;
    FsdeComplemento: string;
    FsdfdeLogradouro: string;
    FsdfnmProprietario: string;
    FsdfcdCategoriaBem: string;
    FsdfdeBairro: string;
    FsrgProprietario: string;
    FsdfVlTitulo: string;
    FsdfdeMarcaModelo: string;
    FsdfNuMatricula: string;
    FsdfdeEspecieTipo: string;
    FsdfNuControle: string;
    FsdfnmDepositario: string;
    FsdfdeCor: string;
    FsdfdtLocalFisico: string;
  published
    property fpgdfcdCategoriaBem: string read FsdfcdCategoriaBem write FsdfcdCategoriaBem;
    property fpgdfdtEntrada: string read FsdfdtEntrada write FsdfdtEntrada;
    property fpgdfNuControle: string read FsdfNuControle write FsdfNuControle;
    property fpgdfdtSituacaoBem: string read FsdfdtSituacaoBem write FsdfdtSituacaoBem;
    property fpgcsSituacaoBem: string read FscsSituacaoBem write FscsSituacaoBem;
    property fpgdfdtLocalFisico: string read FsdfdtLocalFisico write FsdfdtLocalFisico;
    property fpgdfdeLocalFisico: string read FsdfdeLocalFisico write FsdfdeLocalFisico;
    property fpgdfnmDepositario: string read FsdfnmDepositario write FsdfnmDepositario;
    //ARMAS CÓDGO = 1                                                            write                         
    property fpgdfdeArma: string read FsdfdeArma write FsdfdeArma;
    property fpgdfdeSerieArma: string read FsdfdeSerieArma write FsdfdeSerieArma;
    property fpgdfdeCorArma: string read FsdfdeCorArma write FsdfdeCorArma;
    property fpgdfdeMarcaArma: string read FsdfdeMarcaArma write FsdfdeMarcaArma;
    property fpgdfdeDimensaoArma: string read FsdfdeDimensaoArma write FsdfdeDimensaoArma;
    property fpgdfdeCalibreArma: string read FsdfdeCalibreArma write FsdfdeCalibreArma;
    property fpgdfdeCaboArma: string read FsdfdeCaboArma write FsdfdeCaboArma;
    property fpgmmdeComplementoArma: string read FsmmdeComplementoArma write FsmmdeComplementoArma;
    //IMÓVEL CÓDGO = 4                                                                                        
    property fpgdfnuRegistro: string read FsdfnuRegistro write FsdfnuRegistro;
    property fpgdfNuMatricula: string read FsdfNuMatricula write FsdfNuMatricula;
    property fpgdfdtAvaliacaoImovel: string read FsdfdtAvaliacaoImovel write FsdfdtAvaliacaoImovel;
    property fpgdfvlAvaliacaoImovel: string read FsdfvlAvaliacaoImovel write FsdfvlAvaliacaoImovel;
    property fpgdfCEP: string read FsdfCEP write FsdfCEP;
    property fpgdfcdMunicipio: string read FsdfcdMunicipio write FsdfcdMunicipio;
    property fpgdfdeBairro: string read FsdfdeBairro write FsdfdeBairro;
    property fpgdfdeLogradouro: string read FsdfdeLogradouro write FsdfdeLogradouro;
    property fpgdfNumero: string read FsdfNumero write FsdfNumero;
    property fpgdfdeComplemento: string read FsdfdeComplemento write FsdfdeComplemento;
    property fpgdfdeImovel: string read FsdfdeImovel write FsdfdeImovel;
    property fpgrgProprietario: string read FsrgProprietario write FsrgProprietario;
    property fpgdfNmProprietarioImovel: string read FsdfNmProprietarioImove   
      write FsdfNmProprietarioImove;
    //MUNIÇÃO CÓDGO = 2                                                                                     
    property fpggrMunicao: string read FsgrMunicao write FsgrMunicao;
    property fpgdeItemBemMunicao: string read FsdeItemBemMunicao write FsdeItemBemMunicao;
    property fpgqtIntactaMunicao: string read FsqtIntactaMunicao write FsqtIntactaMunicao;
    property fpgqtDeflagradaMunicao: string read FsqtDeflagradaMunicao write FsqtDeflagradaMunicao;
    property fpgdeComplementoMunicao: string read FsdeComplementoMunicao 
      write FsdeComplementoMunicao;
    //OUTROS BENS CÓDGO = 6                                                                                 
    property fpggrOutrosBensObj: string read FsgrOutrosBensObj write FsgrOutrosBensObj;
    property fpgdeItemBem: string read FsdeItemBem write FsdeItemBem;
    property fpgqtIntacta: string read FsqtIntacta write FsqtIntacta;
    property fpgdeComplemento: string read FsdeComplemento write FsdeComplemento;
    //TITULO CÓDGO = 5
    property fpgdfqtBemTitulo: string read FsdfqtBemTitulo write FsdfqtBemTitulo;
    property fpgdfVlTitulo: string read FsdfVlTitulo write FsdfVlTitulo;
    property fpgmmComplTitulo: string read FsmmComplTitulo write FsmmComplTitulo;
    //VEÍCULO CÓDGO = 3                                                                                    
    property fpgdfnuRenavan: string read FsdfnuRenavan write FsdfnuRenavan;
    property fpgdfnuPlaca: string read FsdfnuPlaca write FsdfnuPlaca;
    property fpgdfnuChassi: string read FsdfnuChassi write FsdfnuChassi;
    property fpgdfdeEspecieTipo: string read FsdfdeEspecieTipo write FsdfdeEspecieTipo;
    property fpgdfdeMarcaModelo: string read FsdfdeMarcaModelo write FsdfdeMarcaModelo;
    property fpgdfnuAnoFab: string read FsdfnuAnoFab write FsdfnuAnoFab;
    property fpgdfnuAnoMod: string read FsdfnuAnoMod write FsdfnuAnoMod;
    property fpgdfdeCor: string read FsdfdeCor write FsdfdeCor;
    property fpgdfnmProprietario: string read FsdfnmProprietario write FsdfnmProprietario;
    property fpgmmdeComplemento: string read FsmmdeComplemento write FsmmdeComplemento;
  public
    destructor Destroy; override;
  end;

  TffpgCadEnderecoModelTests = class(TfpgModelTests)
  private
    FbEnderecoPrincipal: boolean;
    FsCEP: string;
    FsNumero: string;
  published
    property fpgEnderecoPrincipal: boolean read FbEnderecoPrincipal write FbEnderecoPrincipal;
    property fpgCEP: string read FsCEP write FsCEP;
    property fpgNumero: string read FsNumero write FsNumero;

  end;

  TffpgCadProcessoModelTests = class(TfpgModelTests)
  private

    FoDadosPrecatoriaModelTests: TffpgPrecatoriaModelTests;
    FoObjetoAcaoModelTests: TffpgObjetoAcaoModelTests;
    FoOutrosNumerosModelTests: TffpgOutrosNumerosModelTests;
    FoAssuntoModelTests: TffpgAssuntoModelTests;
    FoCadParteRepresModelTests: TffpgCadParteRepresModelTests;
    FoDadosDelegaciaModelTests: TffpgDelegaciaModelTests;
    FoCadArmasBensModelTests: TffpgCadArmasBensModelTests;
    FoCadEnderecoModelTests: TffpgCadEnderecoModelTests;
    FbUsarArquivoExterno: boolean;
    FbDigitalizarPecas: boolean;
    FbProcessoExterno: boolean;
    FbEmitirDocs: boolean;
    FbDistribuir: boolean;
    FbProcessoDependente: boolean;
    FbSemCustasIniciais: boolean;
    FbAgendarAudiencia: boolean;
    FbCancelarAudiencia: boolean;
    FsVolumes: string;
    FsValoracao: string;
    FsCodVaraDirecionada: string;
    FsTipoSigilo: string;
    FsForo: string;
    FsAssuntoPrincipal: string;
    FsClasse: string;
    FsTipoDistribuicao: string;
    FsSituacaoAudiencia: string;
    FsMunicipio: string;
    FsTipoAudiencia: string;
    FsCompetencia: string;
    FsCdCategoriaDoc: string;
    FsObjetoAcao: string;
    FsArea: string;
    FsMotivo: string;
    FsCdModeloCategoriaDoc: string;
    FsCertificado: string;
    FsDataValoracao: string;
    FsFolhas: string;
    FbAbrirDoMenu: boolean;
    FsOrgaoSuperior: string;
    FbPossuiEqtaAutuacao: boolean;
    FbControladoForaUso: boolean;
    FbFecharTodasTelas: boolean;
  public
    destructor Destroy; override;
    procedure CarregarModelTest(poCDS: TspClientDataSet); override;
    procedure LiberarModelTest; override;
    class function VerificarCadastroProcesso(psNuProcesso, psCdProcesso, psTpSigilo,
      psCdUsuario: string): boolean;
    class function VerificarOutrosNumerosObservacao(psOutroNumero, psDescricao,
      psObservacao, psNuProcesso: string): boolean;
    class function VerificarOutroAssunto(psAssunto, psFlPrincipal, psFlEtiqueta,
      psNuProcesso: string): boolean;
    class function VerificarArmasEBensCadastrado(psCategoriaBem, psLocalizacaoBem,
      psNuProcesso: string): boolean;
    class function RetornarSiglaCliente: string;
  published
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgArea: string read FsArea write FsArea;
    property fpgAssuntoPrincipal: string read FsAssuntoPrincipal write FsAssuntoPrincipal;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgCodVaraDirecionada: string read FsCodVaraDirecionada write FsCodVaraDirecionada;
    property fpgObjetoAcao: string read FsObjetoAcao write FsObjetoAcao;
    property fpgVolumes: string read FsVolumes write FsVolumes;
    property fpgFolhas: string read FsFolhas write FsFolhas;
    property fpgValoracao: string read FsValoracao write FsValoracao;
    property fpgDataValoracao: string read FsDataValoracao write FsDataValoracao;
    property fpgMunicipio: string read FsMunicipio write FsMunicipio;
    property fpgSemCustasIniciais: boolean read FbSemCustasIniciais write FbSemCustasIniciais;
    property fpgDistribuir: boolean read FbDistribuir write FbDistribuir;
    property fpgTipoSigilo: string read FsTipoSigilo write FsTipoSigilo;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgUsarArquivoExterno: boolean read FbUsarArquivoExterno write FbUsarArquivoExterno;
    property fpgAgendarAudiencia: boolean read FbAgendarAudiencia write FbAgendarAudiencia;
    property fpgCancelarAudiencia: boolean read FbCancelarAudiencia write FbCancelarAudiencia;
    property fpgSituacaoAudiencia: string read FsSituacaoAudiencia write FsSituacaoAudiencia;
    property fpgForo: string read FsForo write FsForo;
    property fpgEmitirDocs: boolean read FbEmitirDocs write FbEmitirDocs;
    property fpgProcessoExterno: boolean read FbProcessoExterno write FbProcessoExterno;
    property fpgProcessoDependente: boolean read FbProcessoDependente write FbProcessoDependente;
    property fpgTipoAudiencia: string read FsTipoAudiencia write FsTipoAudiencia;
    property fpgCdCategoriaDoc: string read FsCdCategoriaDoc write FsCdCategoriaDoc;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgCdModeloCategoriaDoc: string read FsCdModeloCategoriaDoc 
      write FsCdModeloCategoriaDoc;
    property fpgDigitalizarPecas: boolean read FbDigitalizarPecas write FbDigitalizarPecas;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgPossuiEqtaAutuacao: boolean read FbPossuiEqtaAutuacao write FbPossuiEqtaAutuacao;
    property fpgOrgaoSuperior: string read FsOrgaoSuperior write FsOrgaoSuperior;
    property fpgControladoForaUso: boolean read FbControladoForaUso write FbControladoForaUso;
    property fpgFecharTodasTelas: boolean read FbFecharTodasTelas write FbFecharTodasTelas;


    //ModelTests dos SubRoteiros
    property fpgCadParteRepresModelTests: TffpgCadParteRepresModelTests   
      read FoCadParteRepresModelTests write FoCadParteRepresModelTests;
    property fpgDelegaciaModelTests: TffpgDelegaciaModelTests   
      read FoDadosDelegaciaModelTests write FoDadosDelegaciaModelTests;
    property fpgPrecatoriaModelTests: TffpgPrecatoriaModelTests   
      read FoDadosPrecatoriaModelTests write FoDadosPrecatoriaModelTests;
    property fpgObjetoAcaoModelTests: TffpgObjetoAcaoModelTests   
      read FoObjetoAcaoModelTests write FoObjetoAcaoModelTests;
    property fpgOutrosNumerosModelTests: TffpgOutrosNumerosModelTests   
      read FoOutrosNumerosModelTests write FoOutrosNumerosModelTests;
    property fpgAssuntoModelTests: TffpgAssuntoModelTests   
      read FoAssuntoModelTests write FoAssuntoModelTests;
    property fpgCadArmasBensModelTests: TffpgCadArmasBensModelTests   
      read FoCadArmasBensModelTests write FoCadArmasBensModelTests;
    property fpgCadEnderecoModelTests: TffpgCadEnderecoModelTests   
      read FoCadEnderecoModelTests write FoCadEnderecoModelTests;
  end;

implementation

uses
  SysUtils, usegRepositorio, ufpgConstanteGUITests;

{ TffpgCadProcessoCompletoModelTests }

procedure TffpgCadProcessoModelTests.CarregarModelTest(poCDS: TspClientDataSet);
begin
  inherited;
  fpgCadParteRepresModelTests := TffpgCadParteRepresModelTests.Create; //PC_OK
  fpgDelegaciaModelTests := TffpgDelegaciaModelTests.Create; //PC_OK
  fpgPrecatoriaModelTests := TffpgPrecatoriaModelTests.Create; //PC_OK
  fpgObjetoAcaoModelTests := TffpgObjetoAcaoModelTests.Create; //PC_OK
  fpgOutrosNumerosModelTests := TffpgOutrosNumerosModelTests.Create; //PC_OK
  fpgAssuntoModelTests := TffpgAssuntoModelTests.Create; //PC_OK
  fpgCadArmasBensModelTests := TffpgCadArmasBensModelTests.Create; //PC_OK
  fpgCadEnderecoModelTests := TffpgCadEnderecoModelTests.Create; //PC_OK
end;

destructor TffpgCadProcessoModelTests.Destroy;
begin
  inherited;
end;

class function TffpgCadProcessoModelTests.VerificarCadastroProcesso(
  psNuProcesso, psCdProcesso, psTpSigilo, psCdUsuario: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    if psTpSigilo = CS_SIGILO_ABSOLUTO then
      sSQL := VerificarProcessoCadastradoSigiloAbsolutoSQL(psNuProcesso, psCdUsuario)
    else
      sSQL := VerificarProcessoCadastradoSQL(psNuProcesso, psCdProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadProcessoModelTests.VerificarArmasEBensCadastrado(
  psCategoriaBem, psLocalizacaoBem, psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarArmasEBensCadastradoSQL(psCategoriaBem, psLocalizacaoBem, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ENCONTROU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadProcessoModelTests.VerificarOutrosNumerosObservacao(
  psOutroNumero, psDescricao, psObservacao, psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarOutrosNumerosObservacaoSQL(psOutroNumero, psDescricao,
      psObservacao, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ENCONTROU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadProcessoModelTests.VerificarOutroAssunto(psAssunto,
  psFlPrincipal, psFlEtiqueta, psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarOutroAssuntoSQL(psAssunto, psFlPrincipal, psFlEtiqueta, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ENCONTROU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadProcessoModelTests.RetornarSiglaCliente: string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaSiglaClienteSQL;
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CLIENTE').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

{ TffpgCadArmasBensModelTests }

destructor TffpgCadArmasBensModelTests.Destroy;
begin
  inherited;
end;

procedure TffpgCadProcessoModelTests.LiberarModelTest;
begin
  FreeAndNil(FoCadEnderecoModelTests); //PC_OK
  FreeAndNil(FoCadArmasBensModelTests); //PC_OK
  FreeAndNil(FoAssuntoModelTests); //PC_OK
  FreeAndNil(FoOutrosNumerosModelTests); //PC_OK
  FreeAndNil(FoObjetoAcaoModelTests); //PC_OK
  FreeAndNil(FoDadosPrecatoriaModelTests); //PC_OK
  FreeAndNil(FoDadosDelegaciaModelTests); //PC_OK
  FreeAndNil(FoCadParteRepresModelTests); //PC_OK

  inherited;
end;

end.

