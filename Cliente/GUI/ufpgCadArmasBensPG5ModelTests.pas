unit ufpgCadArmasBensPG5ModelTests;

interface

uses
  ufpgCadArmasBens, ufpgModelTests, SysUtils;

type
  TffpgCadArmasBensPG5ModelTests = class(TfpgModelTests)
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
    FsCompetencia: string;
    FsCivel: boolean;
    FsPartesAtivas: string;
    FsPartesPassivas: string;
    FsSigiloso: boolean;
    FsPartesRepresentantes: string;
    FsPartesTerceiras: string;
    FsDistribuido: boolean;
    FsDescricaoTitulo: string;
    FsCdSituacao: string;
    FsProcessoPenhora: string;
    FsDescricao: string;
    FsProcesso: string;
    FsCdCategoria: string;
    FsNuProcesso: string;
    FsSemCustasIniciais: boolean;
    FsProcessoCompetencia: string;
    FsProcessoAssunto: string;
    FsProcessoClasse: string;
    FsProcessoTpParte: string;
    FbExcluir: boolean;
  public
    class function RetornarBemCadastrado(psNuprocesso: string): boolean;
    class function RetornaNuProcesso: string;
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
    property fpgSigiloso: boolean read FsSigiloso write FsSigiloso;
    property fpgCivel: boolean read FsCivel write FsCivel;
    property fpgPartesAtivas: string read FsPartesAtivas write FsPartesAtivas;
    property fpgPartesPassivas: string read FsPartesPassivas write FsPartesPassivas;
    property fpgPartesTerceiras: string read FsPartesTerceiras write FsPartesTerceiras;
    property fpgPartesRepresentantes: string read FsPartesRepresentantes 
      write FsPartesRepresentantes;
    property fpgDistribuido: boolean read FsDistribuido write FsDistribuido;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgDescricaoTitulo: string read FsDescricaoTitulo write FsDescricaoTitulo;
    property fpgCdCategoria: string read FsCdCategoria write FsCdCategoria;
    property fpgCdSituacao: string read FsCdSituacao write FsCdSituacao;
    property fpgDescricao: string read FsDescricao write FsDescricao;
    property fpgProcesso: string read FsProcesso write FsProcesso;
    property fpgProcessoPenhora: string read FsProcessoPenhora write FsProcessoPenhora;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgSemCustasIniciais: boolean read FsSemCustasIniciais write FsSemCustasIniciais;
    property fpgProcessoClasse: string read FsProcessoClasse write FsProcessoClasse;
    property fpgProcessoAssunto: string read FsProcessoAssunto write FsProcessoAssunto;
    property fpgProcessoCompetencia: string read FsProcessoCompetencia write FsProcessoCompetencia;
    property fpgProcessoTpParte: string read FsProcessoTpParte write FsProcessoTpParte;
    property fpdNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgExcluir: boolean read FbExcluir write FbExcluir;
  end;

implementation

uses
  ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, usegRepositorio;

class function TffpgCadArmasBensPG5ModelTests.RetornarBemCadastrado(psNuprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarCadastroBemSql(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadArmasBensPG5ModelTests.RetornaNuProcesso: string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoSimplesSql;
    oSegRepositorio.SQLOpen(sSQL);
    result := Copy(oSegRepositorio.FieldByName('TESTE').AsString, 1, 13);
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

