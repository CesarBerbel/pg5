unit ufpgVariaveisTestes;

interface

procedure InicializarVariaveisGlobais;

var
  gsNomeMetodo: string;
  gsNuProcesso: string;
  gsNuProcessoSimples: string;
  gsCdProcesso: string;
  gsNuLote: string;
  gsNuDocumento: string;
  gsNuModeloDocumento: string;
  gbDeveTrocarUsuario: boolean = True;
  gbLogarNoSetup: boolean = True;
  gsNomeArquivo: string;
  gsNuGuiaGRJ: string;
  gsCdMandado: string;
  gsNuMandado: string;
  gsTipoEndereco: string;
  gsDiligencias: string;
  gsDataEmissao: string;
  gsZona: string;
  gsDeZona: string;
  gsCategoria: string;
  gsModelo: string;
  gsCdAgente: string;
  gsNuProcessosArray: array of string;
  gsCdProcessosArray: array of string;
  gsDataEmissaoArray: array of string;
  gsNuMandadoArray: array of string;
  gsDeFormaPgto: string;
  gsCdCentral: string;
  gsSituacaoMandado: string;
  gsUsuarioAgente: string;
  gsLotacaoAgente: string;
  gsCdDocumento: string;
  gsNomeAgente: string;
  gsNomePessoaAtivo: string;
  gsNomePessoapassivo: string;
  gbCentralCompartilhada: boolean = False;
  gbMandadoDistribuido: boolean = False;
  gscdTipoDistMand: string;
  gsCdCalculoGRJ: string;
  gsNuAr: string;
  gsDocRecebedor: string;
  gbErroTest: boolean = False;
  gsForo: string;
  gsNuGRJ: string;
  gsLocalOrigem: string;
  gsDataRemessa: string;
  gsLocalDestino: string;
  gsDataRecebimento: string;
  gbRegistrarMensagem: boolean;

implementation

// 08/10/2015  - Leandro.Humbert - SALT: 186660/20/8
//Inicializa as variaveis Globais para execucao dos proximos testes;
procedure InicializarVariaveisGlobais;
begin
  gsNomeMetodo := '';
  gsNuProcesso := '';
  gsCdProcesso := '';
  gsNuLote := '';
  gsNuDocumento := '';
  gsNuModeloDocumento := '';
  gbDeveTrocarUsuario := True;
  gbLogarNoSetup := True;
  gsNomeArquivo := '';
  gsNuGuiaGRJ := '';
  gsNuMandado := '';
  gsTipoEndereco := '';
  gsDiligencias := '';
  gsDataEmissao := '';
  gsSituacaoMandado := '';
  gsZona := '';
  gsDeZona := '';
  gsCategoria := '';
  gsModelo := '';
  gsCdAgente := '';
  gsDeFormaPgto := '';
  gsCdCentral := '';
  gsSituacaoMandado := '';
  gsUsuarioAgente := '';
  gsLotacaoAgente := '';
  gsCdDocumento := '';
  gsNomeAgente := '';
  gsNomePessoaAtivo := '';
  gsNomePessoapassivo := '';
  SetLength(gsNuProcessosArray, 0);
  SetLength(gsDataEmissaoArray, 0);
  SetLength(gsNuMandadoArray, 0);
  gbCentralCompartilhada := False;
  gbMandadoDistribuido := False;
  gsNuProcessoSimples := '';
  gscdTipoDistMand := '';
  gsCdCalculoGRJ := '';
  gsNuAr := '';
  gsDocRecebedor := '';
  gsForo := '';
  gsNuGRJ := '';
  gsLocalOrigem := '';
  gsDataRemessa := '';
  gsLocalDestino := '';
  gsDataRecebimento := '';
  gbRegistrarMensagem := False;
end;


end.

