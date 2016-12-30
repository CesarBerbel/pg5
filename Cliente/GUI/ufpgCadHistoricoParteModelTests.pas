unit ufpgCadHistoricoParteModelTests;

interface

uses
  Classes, ADODB, FutureWindows, SysUtils, ufpgModelTests, ufpgFuncoesGUISQLTests;

type
  TTipoRelatorio = (trGuiaRecolhimento, trCartaDeGuia, trHistoricoDaParte, trFichaDoReu);

  TTipoRemissao = (trSomarTempoCumprido, trSubtrairPenaTotal);

  TaipCadHistoricoParteEventosModelTests = class
    ;

  TaipCadHistoricoParteRestricoesModelTests = class
    ;

  TaipCadHistoricoParteTransacoesModelTests = class
    ;

  TaipCadHistoricoParteSuspensoesModelTests = class
    ;

  TaipCadHistoricoParteMedidaSegurancaModelTests = class
    ;

  TaipCadHistoricoParteMultaModelTests = class
    ;

  TaipCadHistoricoParteSursisModelTests = class
    ;

  TaipCadHistoricoParteRelatorioModelTests = class
    ;

  TaipCadHistoricoParteAcompanhamentoModelTests = class
    ;

  TaipCadHistoricoPartePrisaoModelTests = class
    ;

  TaipCadHistoricoParteRegimeModelTests = class
    ;

  TaipCadHistoricoParteTransitoJulgadoModelTests = class
    ;

  TaipCadHistoricoPartePrestacaoModelTests = class
    ;

  TaipCadHistoricoParteRemicaoModelTests = class
    ;

  // anibal.ferreira - 16/10/2014 - SALT: 162598/1
  TaipCadHistoricoParteComutacaoModelTests = class
    ;

  // anibal.ferreira - 19/11/2014 - SALT: 173746/1
  TaipCadHistoricoParteSituacaoParteModelTests = class
    ;

  TfpgCadHistoricoParteModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsRelatorio: string;
    FsCdEscrivao: string;
    FsExcluirEventos: string;
    FoEvento: TaipCadHistoricoParteEventosModelTests;
    FoRestricoes: TaipCadHistoricoParteRestricoesModelTests;
    FoTransacoes: TaipCadHistoricoParteTransacoesModelTests;
    FoSuspensoes: TaipCadHistoricoParteSuspensoesModelTests;
    FoMedidaSeguranca: TaipCadHistoricoParteMedidaSegurancaModelTests;
    FoMulta: TaipCadHistoricoParteMultaModelTests;
    FoSursis: TaipCadHistoricoParteSursisModelTests;
    FoRelatorio: TaipCadHistoricoParteRelatorioModelTests;
    FoAcompanhamento: TaipCadHistoricoParteAcompanhamentoModelTests;
    FoPrisao: TaipCadHistoricoPartePrisaoModelTests;
    FoRegime: TaipCadHistoricoParteRegimeModelTests;
    FoTransitoJulgado: TaipCadHistoricoParteTransitoJulgadoModelTests;
    FoPrestacao: TaipCadHistoricoPartePrestacaoModelTests;
    FoRemicao: TaipCadHistoricoParteRemicaoModelTests;
    // anibal.ferreira - 16/10/2014 - SALT: 162598/1
    FoComutacao: TaipCadHistoricoParteComutacaoModelTests;
    FsAcaoRemoverTransitadoJulgado: string;
    FoSituacaoParte: TaipCadHistoricoParteSituacaoParteModelTests;
    FbVerificarRelatoriohistParte: boolean;
    FsCodVaraDirecionada: string;
    FsDataDelito: string;
    FsNomePessoa: string;
    FsQtdeReus: string;
    FsCodDocumento: string;
    FsCEP: string;
    FsAssunto: string;
    FsAutoridade: string;
    FsTpPartes: string;
    FsNuDocumento: string;
    FsClasse: string;
    FsCompetencia: string;
    FsCodDistrito: string;
    FsTipoDistribuicao: string;
    FsAlteraReuMsg: boolean;
    FsCdForo: string;
    FsVisualizarRelatorio: boolean;
    FsValidaPrevisoes: boolean;
    FsHistoricoParte: boolean;
    FsGuiaRecolhimento: boolean;
    FsJuiz: string;
    FsEscrivao: string;
    fsAcaoFinalizar: string;
    fsCertificado: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    //    procedure LiberarModelTest; override;
    class function VerificarCadastroIndiciado(psNomePessoa: string; psNuprocesso: string): boolean;
    class function VerificarHistoricoParte(psNuProcesso: string; psQtde: string): boolean;
    class function VerificarParcelaMulta(psNuProcesso: string; psQtdeParcela: string): boolean;
    class function VerificarFeriado(pnForo, psData: string): boolean;
    class function RetornarForoProcesso(psNuprocesso: string): string;
  published
    property aipRelatorio: string read FsRelatorio write FsRelatorio;
    property aipCdEscrivao: string read FsCdEscrivao write FsCdEscrivao;
    property aipExcluirEventos: string read FsExcluirEventos write FsExcluirEventos;
    property aipEvento: TaipCadHistoricoParteEventosModelTests read FoEvento write FoEvento;
    property aipRestricao: TaipCadHistoricoParteRestricoesModelTests   
      read FoRestricoes write FoRestricoes;
    property aipTransacao: TaipCadHistoricoParteTransacoesModelTests   
      read FoTransacoes write FoTransacoes;
    property aipSuspensao: TaipCadHistoricoParteSuspensoesModelTests   
      read FoSuspensoes write FoSuspensoes;
    property aipMedidaSeguranca: TaipCadHistoricoParteMedidaSegurancaModelTests   
      read FoMedidaSeguranca write FoMedidaSeguranca;
    property aipMulta: TaipCadHistoricoParteMultaModelTests read FoMulta write FoMulta;
    property aipSursis: TaipCadHistoricoParteSursisModelTests read FoSursis write FoSursis;
    property aipAbaRelatorio: TaipCadHistoricoParteRelatorioModelTests   
      read FoRelatorio write FoRelatorio;
    property aipAcompanhamento: TaipCadHistoricoParteAcompanhamentoModelTests   
      read FoAcompanhamento write FoAcompanhamento;
    property aipNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property aipPrisao: TaipCadHistoricoPartePrisaoModelTests read FoPrisao write FoPrisao;
    property aipRegime: TaipCadHistoricoParteRegimeModelTests read FoRegime write FoRegime;
    property aipTransitoJulgado: TaipCadHistoricoParteTransitoJulgadoModelTests   
      read FoTransitoJulgado write FoTransitoJulgado;
    property aipPrestacao: TaipCadHistoricoPartePrestacaoModelTests 
      read FoPrestacao write FoPrestacao;
    property aipRemicao: TaipCadHistoricoParteRemicaoModelTests read FoRemicao write FoRemicao;
    property aipAcaoRemoverTransitadoJulgado: string   
      read FsAcaoRemoverTransitadoJulgado write FsAcaoRemoverTransitadoJulgado;
    // anibal.ferreira - 16/10/2014 - SALT: 162598/1
    property aipComutacao: TaipCadHistoricoParteComutacaoModelTests   
      read FoComutacao write FoComutacao;
    // anibal.ferreira - 19/11/2014 - SALT: 173746/1
    property aipSituacaoParte: TaipCadHistoricoParteSituacaoParteModelTests   
      read FoSituacaoParte write FoSituacaoParte;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgAssunto: string read FsAssunto write FsAssunto;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgCEP: string read FsCEP write FsCEP;
    property fpgNomePessoa: string read FsNomePessoa write FsNomePessoa;
    property fpgCodDistrito: string read FsCodDistrito write FsCodDistrito;
    property fpgAutoridade: string read FsAutoridade write FsAutoridade;
    property fpgCodDocumento: string read FsCodDocumento write FsCodDocumento;
    property fpgNuDocumento: string read FsNuDocumento write FsNuDocumento;
    property fpgDataDelito: string read FsDataDelito write FsDataDelito;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgCodVaraDirecionada: string read FsCodVaraDirecionada write FsCodVaraDirecionada;
    property fpgVerificarRelatoriohistParte: boolean   
      read FbVerificarRelatoriohistParte write FbVerificarRelatoriohistParte;
    property fpgTpPartes: string read FsTpPartes write FsTpPartes;
    property fpgQtdeReus: string read FsQtdeReus write FsQtdeReus;
    property fpgAlteraReuMsg: boolean read FsAlteraReuMsg write FsAlteraReuMsg;
    property fpgCdForo: string read FsCdForo write FsCdForo;
    property fpgVisualizarRelatorio: boolean read FsVisualizarRelatorio 
      write FsVisualizarRelatorio;
    property fpgValidaPrevisoes: boolean read FsValidaPrevisoes write FsValidaPrevisoes;
    property fpgHistoricoParte: boolean read FsHistoricoParte write FsHistoricoParte;
    property fpgGuiaRecolhimento: boolean read FsGuiaRecolhimento write FsGuiaRecolhimento;
    property fpgJuiz: string read FsJuiz write FsJuiz;
    property fpgEscrivao: string read FsEscrivao write FsEscrivao;
    property fpgAcaoFinalizar: string read fsAcaoFinalizar write fsAcaoFinalizar;
    property fpgCertificado: string read fsCertificado write fsCertificado;
  end;

  TaipCadHistoricoParteCapitulacaoModelTests = class(TfpgModelTests)
  private
    FbPreencherCampoArtigo: boolean;
    FsArtigo: string;
    FbTelaConsultaCapitulacao: boolean;
    FsCapitulacaoTexto: string;
    FsCapitulacaoTextoNodoPai: string;
    FsAnosSentenca: string;
    FbMulta: boolean;
    FbUsarE: boolean;
    FsCapitulacao: string;
  published
    property aipCapitulacao: string read FsCapitulacao write FsCapitulacao;
    property aipPreencherCampoArtigo: boolean read FbPreencherCampoArtigo 
      write FbPreencherCampoArtigo;
    property aipArtigo: string read FsArtigo write FsArtigo;
    property aipTelaConsultaCapitulacao: boolean 
      read FbTelaConsultaCapitulacao   write FbTelaConsultaCapitulacao;
    property aipCapitulacaoTexto: string read FsCapitulacaoTexto write FsCapitulacaoTexto;
    property aipCapitulacaoTextoNodoPai: string read FsCapitulacaoTextoNodoPai   
      write FsCapitulacaoTextoNodoPai;
    property aipAnosSentenca: string read FsAnosSentenca write FsAnosSentenca;
    property aipMulta: boolean read FbMulta write FbMulta;
    property aipUsarE: boolean read FbUsarE write FbUsarE;
  end;

  TaipCadHistoricoParteEventosModelTests = class(TfpgModelTests)
  private
    FsData: string;
    FsNuEvento: string;
    FsAto: string;
    FbPressionarIns: boolean;
    FbPressionarDel: boolean;
    FsAlterarParticipacao: string;
    FbCopiarDadosCap: boolean;
    FsCapitulacao: string;
    FsAbaSentenca: string;
    FsRegime: string;
    FbAcaoDeletar: string;
    FsRestricao: string;
    FsTransacao: string;
    FsSuspensao: string;
    FbRolSuspensos: string;
    FsMedidaSeguranca: string;
    FsMulta: string;
    FsSursis: string;
    FsAcaoSentencaCondenatoria: string;
    FoCadHistoricoParteCapitulacao: TaipCadHistoricoParteCapitulacaoModelTests;
    FsAcompanhamento: string;
    FsPrisao: string;
    FsTipoRegime: string;
    FsTransitoJulgado: string;
    FsPrestacao: string;
    FsTestarCalculo: string;
    FsTestarProgressaoRegime: string;
    FsTestarControlePena: string;
    FsTestarLivramentoCondicional: string;
    FsTestarSaidaTemporaria: string;
    FsRemicao: string;
    FsIDTesteSomaPena: string;
    FsIDTesteUnificacaoPena: string;
    FsDataNaoPodeSerAlterada: string;
    FsParteDiferente: string;
    FsProcessoNaoPossuiSentenca: string;
    FsCopiarDadosDeMulta: string;
    FbReincidente: string;
    FsSituacaoParte: string;
    FsRegimeDetencao: string;
    FsRegimeReclusao: string;
    FsDataOriginal: string;
    FsTestarSituacaoParte: string;
    FsAcaoPedeJuiz: string;
    FsRegimePrisaoSimples: string;
    // anibal.ferreira - 22/10/2014 - SALT: 162598/1
    FsIDComutacao: string;
    // anibal.ferreira - 20/11/2014 - SALT: 173746/1
    FsIDSituacaoParte: string;
    FsRegimeBrando: string;
    FsDataTransitoJulgado: string;
    FsCapitulacaoOutroTexto: string;
    FsLocal: string;
    FsPreencherCampoArtigo: boolean;
    FsConsidera: string;
    FsCapitulacaoTexto: string;
    FsOutroArtigo: string;
    FsCapitulacaoTextoNodoPai: string;
    FsAnos: string;
    FsNuVezes: string;
    FsDias: string;
    FsMeses: string;
    FsObjetoDaAcao: string;
    FsArtigo: string;
    FsTipoPrisao: string;
    FsTipoLocal: string;
    FsAbaTrasitoJulgado: string;
    FsPressionarIns: boolean;
    FsTelaConsultaCapitulacao: boolean;
    FsPressionarDel: boolean;
    FsCapitulacaoOutroTextoNodoPai: string;
    FSDataComparacao: string;
    FsCapitulacaoTextoNodoPaiBotaoCC: string;
    FsCapitulacaoTextoBotaoCC: string;
    FsOutroArtigoBotaoCC: string;
    FsCapitulacaoTextoBotaoCombinacao: string;
    FsCapitulacaoTextoNodoPaiBotaoCombinacao: string;
    FsCheckBoxRegimeBrandoVisible: string;
    FsCheckBoxRegimeBrandoEnabled: string;
    FsOutroArtigoBotaoCombinado: string;
    FbPreencherMulta: boolean;
    FsQtdParcelas: string;
    FbCapitulacao: boolean;
    FsCopiarDadosCap: string;
    FbAbaSentenca: boolean;
    FbPreencherSursis: boolean;
    FbRestrititva: boolean;
    FbRegistraMsgTipoParticipacao: boolean;
  published
    property aipData: string read FsData write FsData;
    property aipNuEvento: string read FsNuEvento write FsNuEvento;
    property aipAto: string read FsAto write FsAto;
    property aipCapitulacao: string read FsCapitulacao write FsCapitulacao;
    property aipPressionarIns: boolean read FbPressionarIns write FbPressionarIns;
    property aipPressionarDel: boolean read FbPressionarDel write FbPressionarDel;
    property aipAlterarParticipacao: string read FsAlterarParticipacao write FsAlterarParticipacao;
    property aipCopiarDadosCap: string read FsCopiarDadosCap write FsCopiarDadosCap;
    property aipAbaSentenca: string read FsAbaSentenca write FsAbaSentenca;
    property aipRegime: string read FsRegime write FsRegime;
    property aipAcaoDeletar: string read FbAcaoDeletar write FbAcaoDeletar;
    property aipRestricao: string read FsRestricao write FsRestricao;
    property aipTransacao: string read FsTransacao write FsTransacao;
    property aipSuspensao: string read FsSuspensao write FsSuspensao;
    property aipRolSuspensos: string read FbRolSuspensos write FbRolSuspensos;
    property aipMedidaSeguranca: string read FsMedidaSeguranca write FsMedidaSeguranca;
    property aipMulta: string read FsMulta write FsMulta;
    property aipSursis: string read FsSursis write FsSursis;
    property aipAcompanhamento: string read FsAcompanhamento write FsAcompanhamento;
    property aipAcaoSentencaCondenatoria: string 
      read FsAcaoSentencaCondenatoria   write FsAcaoSentencaCondenatoria;
    property aipCadHistoricoParteCapitulacao: TaipCadHistoricoParteCapitulacaoModelTests   
      read FoCadHistoricoParteCapitulacao write FoCadHistoricoParteCapitulacao;
    property aipPrisao: string read FsPrisao write FsPrisao;
    property aipTipoRegime: string read FsTipoRegime write FsTipoRegime;
    property aipPrestacao: string read FsPrestacao write FsPrestacao;
    property aipTestarProgressaoRegime: string read FsTestarProgressaoRegime   
      write FsTestarProgressaoRegime;
    property aipTestarCalculo: string read FsTestarCalculo write FsTestarCalculo;
    property aipTestarControlePena: string read FsTestarControlePena write FsTestarControlePena;
    property aipTransitoJulgado: string read FsTransitoJulgado write FsTransitoJulgado;
    property aipRemicao: string read FsRemicao write FsRemicao;
    property aipIDTesteSomaPena: string read FsIDTesteSomaPena write FsIDTesteSomaPena;
    property aipIDTesteUnificacaoPena: string read FsIDTesteUnificacaoPena   
      write FsIDTesteUnificacaoPena;
    property aipTestarLivramentoCondicional: string 
      read FsTestarLivramentoCondicional   write FsTestarLivramentoCondicional;
    property aipTestarSaidaTemporaria: string read FsTestarSaidaTemporaria   
      write FsTestarSaidaTemporaria;
    property aipDataNaoPodeSerAlterada: string read FsDataNaoPodeSerAlterada   
      write FsDataNaoPodeSerAlterada;
    property aipParteDiferente: string read FsParteDiferente write FsParteDiferente;
    property aipProcessoNaoPossuiSentenca: string 
      read FsProcessoNaoPossuiSentenca   write FsProcessoNaoPossuiSentenca;
    property aipCopiarDadosDeMulta: string read FsCopiarDadosDeMulta write FsCopiarDadosDeMulta;
    property aipReincidente: string read FbReincidente write FbReincidente;
    property aipSituacaoParte: string read FsSituacaoParte write FsSituacaoParte;
    property aipRegimeDetencao: string read FsRegimeDetencao write FsRegimeDetencao;
    property aipDataOriginal: string read FsDataOriginal write FsDataOriginal;
    property aipTestarSituacaoParte: string read FsTestarSituacaoParte write FsTestarSituacaoParte;
    property aipAcaoPedeJuiz: string read FsAcaoPedeJuiz write FsAcaoPedeJuiz;
    property aipRegimeReclusao: string read FsRegimeReclusao write FsRegimeReclusao;
    property aipRegimePrisaoSimples: string read FsRegimePrisaoSimples write FsRegimePrisaoSimples;
    // anibal.ferreira - 22/10/2014 - SALT: 162598/1
    property aipIDComutacao: string read FsIDComutacao write FsIDComutacao;
    // 03/11/2014 - marcio.frainer - SALT 162700/1
    property aipRegimeBrando: string read FsRegimeBrando write FsRegimeBrando;
    property aipCheckBoxRegimeBrandoVisible: string 
      read FsCheckBoxRegimeBrandoVisible   write FsCheckBoxRegimeBrandoVisible;
    property aipCheckBoxRegimeBrandoEnabled: string 
      read FsCheckBoxRegimeBrandoEnabled   write FsCheckBoxRegimeBrandoEnabled;
    // anibal.ferreira - 19/11/2014 - SALT: 173746/1
    property aipIDSituacaoParte: string read FsIDSituacaoParte write FsIDSituacaoParte;
    //10/09/2015 - ANTONIO.SOUSA - SALT: 186660/15/1
    property fpgData: string read FsData write FsData;
    property fpgDataTransitoJulgado: string read FsDataTransitoJulgado write FsDataTransitoJulgado;
    property fpgNuEvento: string read FsNuEvento write FsNuEvento;
    property fpgPressionarIns: boolean read FsPressionarIns write FsPressionarIns;
    property fpgPressionarDel: boolean read FsPressionarDel write FsPressionarDel;
    property fpgCopiarDadosCap: boolean read FbCopiarDadosCap write FbCopiarDadosCap;
    property fpgAbaSentenca: boolean read FbAbaSentenca write FbAbaSentenca;
    property fpgAbaTrasitoJulgado: string read FsAbaTrasitoJulgado write FsAbaTrasitoJulgado;
    property fpgCapitulacao: boolean read FbCapitulacao write FbCapitulacao;
    property fpgPreencherCampoArtigo: boolean read FsPreencherCampoArtigo 
      write FsPreencherCampoArtigo;
    property fpgArtigo: string read FsArtigo write FsArtigo;
    property fpgOutroArtigo: string read FsOutroArtigo write FsOutroArtigo;
    property fpgTelaConsultaCapitulacao: boolean 
      read FsTelaConsultaCapitulacao   write FsTelaConsultaCapitulacao;
    property fpgCapitulacaoOutroTexto: string read FsCapitulacaoOutroTexto   
      write FsCapitulacaoOutroTexto;
    property fpgCapitulacaoTexto: string read FsCapitulacaoTexto write FsCapitulacaoTexto;
    property fpgCapitulacaoTextoNodoPai: string read FsCapitulacaoTextoNodoPai   
      write FsCapitulacaoTextoNodoPai;
    property fpgCapitulacaoOutroTextoNodoPai: string   
      read FsCapitulacaoOutroTextoNodoPai write FsCapitulacaoOutroTextoNodoPai;
    property fpgNuVezes: string read FsNuVezes write FsNuVezes;
    property fpgDias: string read FsDias write FsDias;
    property fpgMeses: string read FsMeses write FsMeses;
    property fpgAnos: string read FsAnos write FsAnos;
    property fpgTipoPrisao: string read FsTipoPrisao write FsTipoPrisao;
    property fpgConsidera: string read FsConsidera write FsConsidera;
    property fpgTipoLocal: string read FsTipoLocal write FsTipoLocal;
    property fpgLocal: string read FsLocal write FsLocal;
    property fpgRegime: string read FsRegime write FsRegime;
    property fpgObjetoDaAcao: string read FsObjetoDaAcao write FsObjetoDaAcao;
    property fpgDataComparacao: string read FSDataComparacao write FSDataComparacao;
    property fpgCapitulacaoTextoBotaoCC: string read FsCapitulacaoTextoBotaoCC   
      write FsCapitulacaoTextoBotaoCC;
    property fpgCapitulacaoTextoNodoPaiBotaoCC: string   
      read FsCapitulacaoTextoNodoPaiBotaoCC write FsCapitulacaoTextoNodoPaiBotaoCC;
    property fpgOutroArtigoBotaoCC: string read FsOutroArtigoBotaoCC write FsOutroArtigoBotaoCC;
    property fpgCapitulacaoTextoBotaoCombinacao: string   
      read FsCapitulacaoTextoBotaoCombinacao write FsCapitulacaoTextoBotaoCombinacao;
    property fpgCapitulacaoTextoNodoPaiBotaoCombinacao: string   
      read FsCapitulacaoTextoNodoPaiBotaoCombinacao write FsCapitulacaoTextoNodoPaiBotaoCombinacao;
    property fpgOutroArtigoBotaoCombinado: string 
      read FsOutroArtigoBotaoCombinado   write FsOutroArtigoBotaoCombinado;
    property fpgPreencherMulta: boolean read FbPreencherMulta write FbPreencherMulta;
    property fpgQtdParcelas: string read FsQtdParcelas write FsQtdParcelas;
    property fpgPreencherSursis: boolean read FbPreencherSursis write FbPreencherSursis;
    property fpgRestrititva: boolean read FbRestrititva write FbRestrititva;
    property fpgRegistraMsgTipoParticipacao: boolean   
      read FbRegistraMsgTipoParticipacao write FbRegistraMsgTipoParticipacao;
  end;

  TaipCadHistoricoParteRestricoesModelTests = class(TfpgModelTests)
  private
    FsRestricao: string;
    FsTipoRestricao: string;
    FbMarcarPrivativa: boolean;
    FbMarcarRestritiva: boolean;
    FsAnos: string;
    FsMeses: string;
    FsDias: string;
  published
    property aipRestricao: string read FsRestricao write FsRestricao;
    property aipTipoRestricao: string read FsTipoRestricao write FsTipoRestricao;
    property aipMarcarRestritiva: boolean read FbMarcarRestritiva write FbMarcarRestritiva;
    property aipMarcarPrivativa: boolean read FbMarcarPrivativa write FbMarcarPrivativa;
    property aipAnos: string read FsAnos write FsAnos;
    property aipMeses: string read FsMeses write FsMeses;
    property aipDias: string read FsDias write FsDias;
  end;

  TaipCadHistoricoParteTransacoesModelTests = class(TfpgModelTests)
  private
    FsTransacao: string;
    FsDtInicial: string;
    FsDtFinal: string;
    FsTipoRestricao: string;
  published
    property aipTransacao: string read FsTransacao write FsTransacao;
    property aipDtInicial: string read FsDtInicial write FsDtInicial;
    property aipDtFinal: string read FsDtFinal write FsDtFinal;
    property aipTipoRestricao: string read FsTipoRestricao write FsTipoRestricao;
  end;

  TaipCadHistoricoParteSuspensoesModelTests = class(TfpgModelTests)
  private
    FsSuspensao: string;
    FsDtInicial: string;
    FsDtFinal: string;
    FsTipoRestricao: string;
  published
    property aipSuspensao: string read FsSuspensao write FsSuspensao;
    property aipDtInicial: string read FsDtInicial write FsDtInicial;
    property aipDtFinal: string read FsDtFinal write FsDtFinal;
    property aipTipoRestricao: string read FsTipoRestricao write FsTipoRestricao;
  end;

  TaipCadHistoricoParteMedidaSegurancaModelTests = class(TfpgModelTests)
  private
    FsMedidaSeguranca: string;
    FsInstituicao: string;
    FsAnos: string;
  published
    property aipMedidaSeguranca: string read FsMedidaSeguranca write FsMedidaSeguranca;
    property aipInstituicao: string read FsInstituicao write FsInstituicao;
    property aipAnos: string read FsAnos write FsAnos;
  end;

  TaipCadHistoricoParteMultaModelTests = class(TfpgModelTests)
  private
    FsMulta: string;
    FsBaseCalculo: string;
    FsDiasMulta: string;
  published
    property aipMulta: string read FsMulta write FsMulta;
    property aipBaseCalculo: string read FsBaseCalculo write FsBaseCalculo;
    property aipDiasMulta: string read FsDiasMulta write FsDiasMulta;
  end;

  TaipCadHistoricoParteSursisModelTests = class(TfpgModelTests)
  private
    FsSursis: string;
    FsCondicao: string;
  published
    property aipSursis: string read FsSursis write FsSursis;
    property aipCondicao: string read FsCondicao write FsCondicao;
  end;

  TaipCadHistoricoParteRelatorioModelTests = class(TfpgModelTests)
  private
    FsCdEscrivao: string;
    FsTipoRelatorio: string;
    FbPedeJuiz: boolean;
    FsRemicao: string;
    FbMostrarPrevBen: boolean;
    FbMostrarEndPrinc: boolean;
    FsDestinatario: string;
  published
    property aipCdEscrivao: string read FsCdEscrivao write FsCdEscrivao;
    property aipTipoRelatorio: string read FsTipoRelatorio write FsTipoRelatorio;
    property aipPedeJuiz: boolean read FbPedeJuiz write FbPedeJuiz;
    property aipRemicao: string read FsRemicao write FsRemicao;
    property aipMostrarPrevBen: boolean read FbMostrarPrevBen write FbMostrarPrevBen;
    property aipMostrarEndPrinc: boolean read FbMostrarEndPrinc write FbMostrarEndPrinc;
    property aipDestinatario: string read FsDestinatario write FsDestinatario;
  end;

  TaipCadHistoricoParteAcompanhamentoModelTests = class(TfpgModelTests)
  private
    FsAcompanhamento: string;
    FsTipoAcompanhamento: string;
    FbMarcarPrivativa: boolean;
    FbMarcarRestritiva: boolean;
  published
    property aipAcompanhamento: string read FsAcompanhamento write FsAcompanhamento;
    property aipTipoAcompanhamento: string read FsTipoAcompanhamento write FsTipoAcompanhamento;
    property aipMarcarRestritiva: boolean read FbMarcarRestritiva write FbMarcarRestritiva;
    property aipMarcarPrivativa: boolean read FbMarcarPrivativa write FbMarcarPrivativa;
  end;

  TaipCadHistoricoPartePrisaoModelTests = class(TfpgModelTests)
  private
    FsPrisao: string;
    FsTipoPrisao: string;
    FsConsidera: string;
    FsTipoLocal: string;
    FsLocal: string;
    FsdtTermino: string;
  published
    property aipPrisao: string read FsPrisao write FsPrisao;
    property aipTipoPrisao: string read FsTipoPrisao write FsTipoPrisao;
    property aipConsidera: string read FsConsidera write FsConsidera;
    property aipTipoLocal: string read FsTipoLocal write FsTipoLocal;
    property aipLocal: string read FsLocal write FsLocal;
    property aipDtTermino: string read FsdtTermino write FsdtTermino;
  end;

  TaipCadHistoricoParteRegimeModelTests = class(TfpgModelTests)
  private
    FsTipoRegime: string;
    FsRegime: string;
  published
    property aipTipoRegime: string read FsTipoRegime write FsTipoRegime;
    property aipRegime: string read FsRegime write FsRegime;
  end;

  TaipCadHistoricoPartePrestacaoModelTests = class(TfpgModelTests)
  private
    FsPrestacao: string;
    FsEntidade: string;
  published
    property aipPrestacao: string read FsPrestacao write FsPrestacao;
    property aipEntidade: string read FsEntidade write FsEntidade;
  end;

  TaipCadHistoricoParteTransitoJulgadoModelTests = class(TfpgModelTests)
  private
    FsTransitoJulgado: string;
    FsData: string;
    FsAcaoTransitadoJulgado: string;
    FsAcaoProximoRegistro: string;
  published
    property aipTransitoJulgado: string read FsTransitoJulgado write FsTransitoJulgado;
    property aipData: string read FsData write FsData;
    property aipAcaoTransitadoJulgado: string read FsAcaoTransitadoJulgado   
      write FsAcaoTransitadoJulgado;
    property aipAcaoProximoRegistro: string read FsAcaoProximoRegistro write FsAcaoProximoRegistro;
  end;

  TaipCadHistoricoParteRemicaoModelTests = class(TfpgModelTests)
  private
    FsRemicao: string;
    FsComplemento: string;
    FsDias: string;
  published
    property aipRemicao: string read FsRemicao write FsRemicao;
    property aipComplemento: string read FsComplemento write FsComplemento;
    property aipDias: string read FsDias write FsDias;
  end;

  // anibal.ferreira - 16/10/2014 - SALT: 162598/1
  TaipCadHistoricoParteComutacaoModelTests = class(TfpgModelTests)
  private
    FbDataBaseInvalida: boolean;
    FsFormaComutacao: string;
    FsFracao: string;
    FdDataBase: TDateTime;
    FsRegistrosSelecionar: string;
    FbValidarTotal: boolean;
    FnAplicadaMeses: integer;
    FnPenaMeses: integer;
    FnPenaDias: integer;
    FnAplicadaAnos: integer;
    FnPenaAnos: integer;
    FnAplicadaDias: integer;
    // anibal.ferreira - 20/11/2014 - SALT: 173746/1
    FbMensagemHediondo: boolean;
  published
    property aipDataBase: TDateTime read FdDataBase write FdDataBase;
    property aipFormaComutacao: string read FsFormaComutacao write FsFormaComutacao;
    property aipFracao: string read FsFracao write FsFracao;
    property aipDataBaseInvalida: boolean read FbDataBaseInvalida write FbDataBaseInvalida;
    property aipRegistrosSelecionar: string read FsRegistrosSelecionar write FsRegistrosSelecionar;
    property aipValidarTotal: boolean read FbValidarTotal write FbValidarTotal;
    property aipAplicadaAnos: integer read FnAplicadaAnos write FnAplicadaAnos;
    property aipAplicadaMeses: integer read FnAplicadaMeses write FnAplicadaMeses;
    property aipAplicadaDias: integer read FnAplicadaDias write FnAplicadaDias;
    property aipPenaAnos: integer read FnPenaAnos write FnPenaAnos;
    property aipPenaMeses: integer read FnPenaMeses write FnPenaMeses;
    property aipPenaDias: integer read FnPenaDias write FnPenaDias;
    // anibal.ferreira - 20/11/2014 - SALT: 173746/1
    property aipMensagemHediondo: boolean read FbMensagemHediondo write FbMensagemHediondo;
  end;

  // anibal.ferreira - 19/11/2014 - SALT: 173746/1
  TaipCadHistoricoParteSituacaoParteModelTests = class(TfpgModelTests)
  private
    FnNuSeqCapitulacao: integer;
    FnNuSeqHistParte: integer;
    FnCdSituacaoParte: integer;
    FsMsgErro: string;
  published
    property aipNuSeqHistParte: integer read FnNuSeqHistParte write FnNuSeqHistParte;
    property aipNuSeqCapitulacao: integer read FnNuSeqCapitulacao write FnNuSeqCapitulacao;
    property aipCdSituacaoParte: integer read FnCdSituacaoParte write FnCdSituacaoParte;
    property aipMsgErro: string read FsMsgErro write FsMsgErro;
  end;

implementation

uses
  uSegRepositorio;

constructor TfpgCadHistoricoParteModelTests.Create;
begin
  inherited;
  FoEvento := TaipCadHistoricoParteEventosModelTests.Create; //PC_OK
  FoRestricoes := TaipCadHistoricoParteRestricoesModelTests.Create; //PC_OK
  FoTransacoes := TaipCadHistoricoParteTransacoesModelTests.Create; //PC_OK
  FoSuspensoes := TaipCadHistoricoParteSuspensoesModelTests.Create; //PC_OK
  FoMedidaSeguranca := TaipCadHistoricoParteMedidaSegurancaModelTests.Create; //PC_OK
  FoMulta := TaipCadHistoricoParteMultaModelTests.Create; //PC_OK
  FoSursis := TaipCadHistoricoParteSursisModelTests.Create; //PC_OK
  FoRelatorio := TaipCadHistoricoParteRelatorioModelTests.Create; //PC_OK
  FoEvento.FoCadHistoricoParteCapitulacao := TaipCadHistoricoParteCapitulacaoModelTests.Create; //PC_OK
  FoAcompanhamento := TaipCadHistoricoParteAcompanhamentoModelTests.Create; //PC_OK
  FoPrisao := TaipCadHistoricoPartePrisaoModelTests.Create; //PC_OK
  FoRegime := TaipCadHistoricoParteRegimeModelTests.Create; //PC_OK
  FoTransitoJulgado := TaipCadHistoricoParteTransitoJulgadoModelTests.Create; //PC_OK
  FoPrestacao := TaipCadHistoricoPartePrestacaoModelTests.Create; //PC_OK
  FoRemicao := TaipCadHistoricoParteRemicaoModelTests.Create; //PC_OK
  // anibal.ferreira - 22/10/2014 - SALT: 162598/1
  FoComutacao := TaipCadHistoricoParteComutacaoModelTests.Create; //PC_OK
  // anibal.ferreira - 19/11/2014 - SALT: 173746/1
  FoSituacaoParte := TaipCadHistoricoParteSituacaoParteModelTests.Create; //PC_OK
end;

destructor TfpgCadHistoricoParteModelTests.Destroy;
begin
  inherited;
  FreeAndNil(FoRestricoes); //PC_OK
  FreeAndNil(FoTransacoes); //PC_OK
  FreeAndNil(FoSuspensoes); //PC_OK
  FreeAndNil(FoMedidaSeguranca); //PC_OK
  FreeAndNil(FoMulta); //PC_OK
  FreeAndNil(FoSursis); //PC_OK
  FreeAndNil(FoRelatorio); //PC_OK
  FreeAndNil(FoEvento.FoCadHistoricoParteCapitulacao); //PC_OK
  FreeAndNil(FoEvento); //PC_OK
  FreeAndNil(FoAcompanhamento); //PC_OK
  FreeAndNil(FoPrisao); //PC_OK
  FreeAndNil(FoRegime); //PC_OK
  FreeAndNil(FoTransitoJulgado); //PC_OK
  FreeAndNil(FoPrestacao); //PC_OK
  FreeAndNil(FoRemicao); //PC_OK
  // anibal.ferreira - 22/10/2014 - SALT: 162598/1
  FreeAndNil(FoComutacao); //PC_OK
  // anibal.ferreira - 19/11/2014 - SALT: 173746/1
  FreeAndNil(FoSituacaoParte); //PC_OK
end;

class function TfpgCadHistoricoParteModelTests.VerificarCadastroIndiciado(psNomePessoa: string;
  psNuprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarParteIndiciado(psNomePessoa, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('PESSOACADASTRADA').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TfpgCadHistoricoParteModelTests.VerificarHistoricoParte(psNuProcesso: string;
  psQtde: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarHistoricoParte(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = StrToInt(psQtde);
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TfpgCadHistoricoParteModelTests.VerificarParcelaMulta(psNuProcesso: string;
  psQtdeParcela: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarParcelasMulta(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = StrToInt(psQtdeParcela);
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TfpgCadHistoricoParteModelTests.VerificarFeriado(pnForo, psData: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarFeriadoSql(pnForo, psData);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;

end;

class function TfpgCadHistoricoParteModelTests.RetornarForoProcesso(psNuprocesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaForoProcessoSQL(psNuprocesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDFORO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

