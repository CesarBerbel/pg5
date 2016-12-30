unit ufpgVisualizaProcessoModelTests;

interface

uses
  ufpgVisualizaProcesso, ufpgDataModelTests, ADODB, SysUtils;

type
  TffpgVisualizaProcessoModelTests = class(TfpgDataModelTests)
  private
    FsNuProcesso: string;
    FsSenha: string;
    FsCertificado: string;
    FsExclusaoMotivo: string;
    FsCdCertidao: string;
    FsComplPadrao: string;
    FsBairro: string;
    FsRua: string;
    FsMotivo: string;
    FsCEP: string;
    FsTipoDocumento: string;
    FsVaraDist: string;
    FsClasse: string;
    FsAutoridade: string;
    FsMunicipio: string;
    FsDistribuicao: string;
    FsDistrito: string;
    FsAssunto: string;
    FsCompetencia: string;
    FsEncontrouAnotacao: string;
    FsNomeCampoAnotacao: string;
    FsTpDocNovo: string;
    FsEncontrouDoc: string;
    FsNomeCampoDoc: string;
    FsMotivoSemEfeito: string;
    FsEncontrouSemEfeito: string;
    FsNomeCampoSemEfeito: string;
    FsTpDocAutos: string;
    FsAnotacao: string;
    FsInserirAnotacao: boolean;
    FsTornarDocSemEfeito: boolean;
    FsAlterarTipoDoc: boolean;
    FsLiberarNosAutos: boolean;
    FsConsultarPropriedades: boolean;
    FsAlterarOrdenacaoAnotacoes: boolean;
    FsVerificarNuProcTarjaAss: boolean;
    FbfpgVerificarOrdemTarja: boolean;

  public
    class function VerificacoesTesteConsultaAltos(psNuProcesso, psAnotacao,
      psAhSerVerificado, psResultado: string): boolean;
    class function RetornarCdProcesso(psNuprocesso: string): string;
    class function RetornaNuProcessoCompleto(psNuProcesso: string): string;
  published
    //Data methods
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgSenha: string read FsSenha write FsSenha;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgExclusaoMotivo: string read FsExclusaoMotivo write FsExclusaoMotivo;
    property fpgCdCertidao: string read FsCdCertidao write FsCdCertidao;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgAssunto: string read FsAssunto write FsAssunto;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgDistribuicao: string read FsDistribuicao write FsDistribuicao;
    property fpgDistrito: string read FsDistrito write FsDistrito;
    property fpgAutoridade: string read FsAutoridade write FsAutoridade;
    property fpgTipoDocumento: string read FsTipoDocumento write FsTipoDocumento;
    property fpgMunicipio: string read FsMunicipio write FsMunicipio;
    property fpgCEP: string read FsCEP write FsCEP;
    property fpgComplPadrao: string read FsComplPadrao write FsComplPadrao;
    property fpgRua: string read FsRua write FsRua;
    property fpgBairro: string read FsBairro write FsBairro;
    property fpgVaraDist: string read FsVaraDist write FsVaraDist;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgNomeCampoAnotacao: string read FsNomeCampoAnotacao write FsNomeCampoAnotacao;
    property fpgEncontrouAnotacao: string read FsEncontrouAnotacao write FsEncontrouAnotacao;
    property fpgTpDocNovo: string read FsTpDocNovo write FsTpDocNovo;
    property fpgNomeCampoDoc: string read FsNomeCampoDoc write FsNomeCampoDoc;
    property fpgEncontrouDoc: string read FsEncontrouDoc write FsEncontrouDoc;
    property fpgMotivoSemEfeito: string read FsMotivoSemEfeito write FsMotivoSemEfeito;
    property fpgNomeCampoSemEfeito: string read FsNomeCampoSemEfeito write FsNomeCampoSemEfeito;
    property fpgEncontrouSemEfeito: string read FsEncontrouSemEfeito write FsEncontrouSemEfeito;
    property fpgTpDocAutos: string read FsTpDocAutos write FsTpDocAutos;
    property fpgAnotacao: string read FsAnotacao write FsAnotacao;
    property fpgConsultarPropriedades: boolean read FsConsultarPropriedades   
      write FsConsultarPropriedades;
    property fpgLiberarNosAutos: boolean read FsLiberarNosAutos write FsLiberarNosAutos;
    property fpgInserirAnotacao: boolean read FsInserirAnotacao write FsInserirAnotacao;
    property fpgAlterarTipoDoc: boolean read FsAlterarTipoDoc write FsAlterarTipoDoc;
    property fpgTornarDocSemEfeito: boolean read FsTornarDocSemEfeito write FsTornarDocSemEfeito;
    property fpgAlterarOrdenacaoAnotacoes: boolean 
      read FsAlterarOrdenacaoAnotacoes   write FsAlterarOrdenacaoAnotacoes;
    property fpgVerificarNuProcTarjaAss: boolean 
      read FsVerificarNuProcTarjaAss   write FsVerificarNuProcTarjaAss;
    property fpgVerificarOrdemTarja: boolean read FbfpgVerificarOrdemTarja   
      write FbfpgVerificarOrdemTarja;


  end;

implementation

uses
  usegRepositorio, ufpgFuncoesSQLTests;

{ TffpgVisualizaProcessoModelTests }

//30/11/2015 - Shirleano.Junior - SALT: 186660/23/4
class function TffpgVisualizaProcessoModelTests.VerificacoesTesteConsultaAltos(
  psNuProcesso, psAnotacao, psAhSerVerificado, psResultado: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  osegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarTesteConsultaAutos(psNuProcesso, psAnotacao);
    osegRepositorio.SQLOpen(sSQL);
    result := osegRepositorio.FieldByName(psAhSerVerificado).AsString = psResultado;
  finally
    FreeAndNil(osegRepositorio);
  end;
end;

class function TffpgVisualizaProcessoModelTests.RetornarCdProcesso(psNuprocesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  osegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarCdProcessoSql(quotedstr(psNuProcesso + '%'));
    osegRepositorio.SQLOpen(sSQL);
    result := osegRepositorio.FieldByName('CDPROCESSO').AsString;
  finally
    FreeAndNil(osegRepositorio);
  end;
end;

class function TffpgVisualizaProcessoModelTests.RetornaNuProcessoCompleto(
  psNuProcesso: string): string;
var
  oSegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarNuProcessoCompleto(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

