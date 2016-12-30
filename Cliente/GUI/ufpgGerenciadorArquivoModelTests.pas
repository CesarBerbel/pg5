unit ufpgGerenciadorArquivoModelTests;

interface

uses
  ufpgGerenciadorArquivo, ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests,
  SysUtils, ufpgFuncoesGUITestes;

type
  TffpgGerenciadorArquivoModelTests = class(TfpgModelTests)
  private
    FbPesquisarPorModelos: boolean;
    FbLocalizarModelo: boolean;
    FsNuProcesso: string;
    FsCdModelo: string;
    FbImprimir: boolean;
    FbConfirmarMov: boolean;
    FbMaisOpcoesPesquisa: boolean;
    FsNomeCompartilhar: string;
    FbDocCompartilhadosUsuario: boolean;
    FsCdCategoria: string;
    FsUsuario: string;
    FsNuDocumento: string;
    FsObservacao: string;
    FbVerificarObservacao: boolean;
    FbAssinarLiberar: boolean;
    FsAcaoFinalizar: string;
    FsCertificado: string;
    FbVerificarSenha: boolean;
    FsCdDocumento: string;
    FsDescModelo: string;
    FsCdProcesso: string;
    FbConsultaData: boolean;
    FsDataFinal: string;
    FsDataInicio: string;
    FbConsultaProcesso: boolean;
    FbConsutlaNome: boolean;
    FbPesquisaUsuarioCriacao: boolean;
    FsNmUsarioCriacao: string;
    FbPesquisaCategoria: boolean;
    FbPesquisaModelo: boolean;
    FbPesaquisaOutrasDatas: boolean;
    FsOutraDataInicial: string;
    FsOutraDataFinal: string;
    FbPesquinaPasta: boolean;
    FsPasta: string;
    FbPesquisaDocCompartilhado: boolean;
    FbCompartilhaPeloUsuario: boolean;
    FbCompartilhaAoUsuario: boolean;
    FbPesquisaMovimentacaoPendente: boolean;
    FbPesquisaOutrosGrupos: boolean;
    FbEditarDocumento: boolean;
  public
    class function VerificaObservacaoEditor(psNuDocumento, psObservacao: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdModelo: string read FsCdModelo write FsCdModelo;
    property fpgPesquisarPorModelos: boolean read FbPesquisarPorModelos 
      write FbPesquisarPorModelos;
    property fpgLocalizarModelo: boolean read FbLocalizarModelo write FbLocalizarModelo;
    property fpgImprimir: boolean read FbImprimir write FbImprimir;
    property fpgConfirmarMov: boolean read FbConfirmarMov write FbConfirmarMov;
    property fpgMaisOpcoesPesquisa: boolean read FbMaisOpcoesPesquisa write FbMaisOpcoesPesquisa;
    property fpgNomeCompartilhar: string read FsNomeCompartilhar write FsNomeCompartilhar;
    property fpgCdCategoria: string read FsCdCategoria write FsCdCategoria;
    property fpgUsuario: string read FsUsuario write FsUsuario;
    property fpgNuDocumento: string read FsNuDocumento write FsNuDocumento;
    property fpgObservacao: string read FsObservacao write FsObservacao;
    property fpgVerificarObservacao: boolean read FbVerificarObservacao 
      write FbVerificarObservacao;
    property fpgAssinarLiberar: boolean read FbAssinarLiberar write FbAssinarLiberar;
    property fpgAcaoFinalizar: string read FsAcaoFinalizar write FsAcaoFinalizar;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgVerificarSenha: boolean read FbVerificarSenha write FbVerificarSenha;
    property fpgCdDocumento: string read FsCdDocumento write FsCdDocumento;
    property fpgDescModelo: string read FsDescModelo write FsDescModelo;
    property fpgCdProcesso: string read FsCdProcesso write FsCdProcesso;
    property fpgConsultaData: boolean read FbConsultaData write FbConsultaData;
    property fpgDataInicio: string read FsDataInicio write FsDataInicio;
    property fpgDataFinal: string read FsDataFinal write FsDataFinal;
    property fpgConsultaProcesso: boolean read FbConsultaProcesso write FbConsultaProcesso;
    property fpgConsultaNome: boolean read FbConsutlaNome write FbConsutlaNome;
    property fpgPesquisaUsuarioCriacao: boolean read FbPesquisaUsuarioCriacao   
      write FbPesquisaUsuarioCriacao;
    property fpgNmUsarioCriacao: string read FsNmUsarioCriacao write FsNmUsarioCriacao;
    property fpgPesquisaCategoria: boolean read FbPesquisaCategoria write FbPesquisaCategoria;
    property fpgPesquisaModelo: boolean read FbPesquisaModelo write FbPesquisaModelo;
    property fpgPesaquisaOutrasDatas: boolean read FbPesaquisaOutrasDatas 
      write FbPesaquisaOutrasDatas;
    property fpgOutraDataInicial: string read FsOutraDataInicial write FsOutraDataInicial;
    property fpgOutraDataFinal: string read FsOutraDataFinal write FsOutraDataFinal;
    property fpgPesquinaPasta: boolean read FbPesquinaPasta write FbPesquinaPasta;
    property fpgPasta: string read FsPasta write FsPasta;
    property fpgPesquisaDocCompartilhado: boolean 
      read FbPesquisaDocCompartilhado   write FbPesquisaDocCompartilhado;
    property fpgCompartilhaPeloUsuario: boolean read FbCompartilhaPeloUsuario   
      write FbCompartilhaPeloUsuario;
    property fpgCompartilhaAoUsuario: boolean read FbCompartilhaAoUsuario 
      write FbCompartilhaAoUsuario;
    property fpgPesquisaMovimentacaoPendente: boolean   
      read FbPesquisaMovimentacaoPendente write FbPesquisaMovimentacaoPendente;
    property fpgPesquisaOutrosGrupos: boolean read FbPesquisaOutrosGrupos 
      write FbPesquisaOutrosGrupos;
    property fpgEditarDocumento: boolean read FbEditarDocumento write FbEditarDocumento;
  end;

implementation

uses
  usegRepositorio;

{ TffpgGerenciadorArquivoModelTests }

class function TffpgGerenciadorArquivoModelTests.VerificaObservacaoEditor(
  psNuDocumento, psObservacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarObservacaoDocumento(psNuDocumento);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('DEOBSERVACAO').AsString = psObservacao;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

