unit ufpgVariaveisTestesGUI;

interface

var
  //Cliente Atual
  gsCliente: string;

  // Tipo de Builds
  gsBuild: string;

  //Processo
  gsCDProcesso: string;
  gsNuProcessosArrayCompleto: array of string;
  gsNuProcessosArray: array of string;
  gsVara: string;
  gsVaga: string;
  gsNomeParteAtivaCPF: string;
  gsNomePartePassivaCPF: string;
  gsNomeParteRepresentanteCPF: string;
  gsNomeParteTestemunhaCPF: string;
  gsCdObjeto: string;

  //Descobrir onde era usada e porque
  gsPendencia: string;

  //Edição de documento
  gsDeFormaPgto: string;
  gsNuDocumento: string;

  //Editor
  gsNuAR: string;

  //Cadastro de modelo
  gsNuModeloDocumento: string;

  //Remessa
  gsNuLote: string;
  gsDataRemessa: string;
  gsLocalOrigem: string;
  gsLocalDestino: string;

  //Recebimento
  gsDataRecebimento: string;

  //Pauta de audiência
  gsDataAudiencia: string;

  //Cadastro de Recado
  gsRecado: string;

  //Verifica Continuação da suite
  gbErroTest: boolean;
  gbErroSQL: boolean;

  //Unificacao / Desmembramento
  gsNomeParte: string;
  gsProcessoDesmembrado: string;

  //Fluxo AR - Alteração AR
  gsDocRecebedor: string;

  //Fluxo AR - ConsCarga AR
  gsNuLoteAR: string;

  //Fluxo Mandados
  gsNuLoteMandado: string;
  gsTipoLocalDestinoMandado: string;
  gsNomeAgente: string;
  gsUsuarioAgente: string;
  gsNuMandado: string;
  gsDataEmissao: string;
  gbMandadoDistribuido: boolean;
  gsCdAgente: string;
  gsCdCentral: string;
  gsSituacaoMandado: string;
  gsDeZona: string;
  gsCategoria: string;
  gsModelo: string;
  gsZona: string;
  gsNuGuiaGRJ: string;
  gsForo: string;
  gsCdMandado: string;
  gscdTipoDistMand: string;
  gsLotacaoAgente: string;

  //Cadastro Pessoas
  gsCdPessoa: string;
  gsCpfPessoa: string;

  //Cadastro cumprimento sentença
  gsNumeroProc: string;
  gsNumeroProcDependente: string;
  //Cadastro PEC
  gsNuPec: string;

  gsTextoCadPessoaControlado: string;

  //PublicacaoIntimacao
  gsSeqRelacao: string;
  gsNuRelacao: string;

  gsSenhaProcesso: string;

  //Certião - Pedidos
  gsNuPedido: string;

  

  //Gerenciador
  gsNmDocumento: string;


implementation

end.

