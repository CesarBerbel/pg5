unit ufpgConsProcBasicaModelTests;

interface

uses
  ufpgModelTests, SysUtils, usajConstante, uspFuncoesDate;

type
  TffpgConsProcBasicaModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
  public
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
//    property fpgClasse: string read FsClasse write FsClasse;
//    property fpgAssunto: string read FsAssunto write FsAssunto;
//    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
//    property fpgTpParte: string read FsTpParte write FsTpParte;
//    property fpgSigilo: string read FsSigilo write FsSigilo;
//    property fpgComplemento: string read FsComplemento write FsComplemento;
//    property fpgPartes: string read FsPartes write FsPartes;
//    property fpgDeClasse: string read FsDeClasse write FsDeClasse;
//    property fpgCEP: string read FsCEP write FsCEP;
//    property fpgRua: string read FsRua write FsRua;
//    property fpgBairro: string read FsBairro write FsBairro;
//    property fpgCadastroCompleto: string read FsCadastroCompleto write FsCadastroCompleto;
//    property fpgPossuiProClasse: boolean read FsPossuiProClasse write FsPossuiProClasse;
//    property fpgJuntar: boolean read FbJuntar write FbJuntar;
//    property fpgPossuiParticipacao: boolean read FbPossuiParticipacao write FbPossuiParticipacao;
//    property fpgPossuiProtocolo: boolean read FbPossuiProtocolo write FbPossuiProtocolo;
//    property fpgAdvogado: string read FsAdvogado write FsAdvogado;
//    property fpgMunicipio: string read FsMunicipio write FsMunicipio;
//    property fpgPossuiSigilo: string read FsPossuiSigilo write FsPossuiSigilo;
//    property fpgCdParteAtiva: string read FsCdParteAtiva write FsCdParteAtiva;
//    property fpgCdPartePassiva: string read FsCdPartePassiva write FsCdPartePassiva;
//    property fpgLotacao: string read FsLotacao write FsLotacao;
//    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
//    property fpgCodVaraDirecionada: string read FsCodVaraDirecionada write FsCodVaraDirecionada;
//    property fpgprocessoDigital: boolean read FsProcessoDigital write FsProcessoDigital;
//    property fpgprocessoApenso: string read FsprocessoApenso write FsprocessoApenso;
//    property fpgProcesso: string read FsProcesso write FsProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgConsProcBasicaModelTests }

end.

