unit ufpgEditorModelTests;

interface

uses
  ufpgEditor, ufpgModelTests, ADODB, ufpgDataModelTests;

type
  TffpgEditorModelTests = class(TfpgModelTests)
  private
    FbCorrigirTexto: boolean;
    FbRegistrarMsgAssinaturaJuiz: boolean;
    FbVerificarDocFinalizado: boolean;
    FbVerificarDocAssinado: boolean;
    FbFinalizaDocumento: boolean;
    FbAbrirDoMenu: boolean;
    FbExportar: boolean;
    FbSalvarDocumento: boolean;
    FbImportar: boolean;
    FbNovoDocumento: boolean;
    FsTextoCerto: string;
    FsAcaoFinalizar: string;
    FsTextoErrado: string;
    FsNuProcesso: string;
    FbAplicarEstilos: boolean;
    FsCertificado: string;
    FsCategoria: string;
    FbCadastrarAutoTexto: boolean;
    FbFecharTela: boolean;
    FbInserirMov: boolean;
    FbFinalizarPainelAuxiliar: boolean;
    FsModoFinalizacao: string;
    FbRgistrarMensagemModeloDependente: boolean;
    FbRegistrarConfirmarConfiguracao: boolean;
    FsModelo: string;
    FbUsaProcesso: boolean;
    FbPintarAmarelo: boolean;
    FbRegistrarConfirmarConfiguracaoImpressao: boolean;
    FbGerarAto: boolean;
    FbNovoAto: boolean;
    FsConvenio: string;
    FsTipoAto: string;
    FsFormaAto: string;
    FsPrazoAto: string;
    FsModeloAto: string;
    FbImprotarMultimidia: boolean;
    FbImprimirAR: boolean;
    FbAbrirEdicaoModelo: boolean;
    FbFecharArquivo: boolean;
    FbMsgSemSalvar: boolean;

    FbEditarOficio: boolean;
    FsTipoDocumento: string;
    FsMovimentacao: string;
    FbLancarMovimentacao: boolean;
    FbRegistrarMsgNaoConfirmado: boolean;
    FbImportarMultimidia: boolean;
    FsObservacao: string;
    FbInserirObeservacao: boolean;
    FbRegistraMsgMandado: boolean;
    FbRegistrarMsgAssinaturaOficialJustica: boolean;

    FbRegistrarMsgEscrivao: boolean;
    FbFinalizaDocumentoMenu: boolean;
    FbVerifcarCopiarColar: boolean;
    FbInserirCompMovParagrafo: boolean;
    FbVerificaQtdeCaracter: boolean;
    FbImprimirBotao: boolean;
  public
    class function VerificarARGerada(psNumAR: string): boolean;
    class function VerificarDocEmitido(psCategoria, psModelo, psNuProcesso: string): boolean;
  published
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgAplicarEstilos: boolean read FbAplicarEstilos write FbAplicarEstilos;
    property fpgCategoria: string read FsCategoria write FsCategoria;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property FpgNovoDocumento: boolean read FbNovoDocumento write FbNovoDocumento;
    property fpgTextoErrado: string read FsTextoErrado write FsTextoErrado;
    property fpgTextoCerto: string read FsTextoCerto write FsTextoCerto;
    property fpgCorrigirTexto: boolean read FbCorrigirTexto write FbCorrigirTexto;
    property fpgSalvarDocumento: boolean read FbSalvarDocumento write FbSalvarDocumento;
    property fpgFinalizaDocumento: boolean read FbFinalizaDocumento write FbFinalizaDocumento;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgExportar: boolean read FbExportar write FbExportar;
    property fpgImportar: boolean read FbImportar write FbImportar;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgCadastrarAutoTexto: boolean read FbCadastrarAutoTexto write FbCadastrarAutoTexto;
    property fpgAcaoFinalizar: string read FsAcaoFinalizar write FsAcaoFinalizar;
    property fpgRegistrarMsgAssinaturaJuiz: boolean 
      read FbRegistrarMsgAssinaturaJuiz   write FbRegistrarMsgAssinaturaJuiz;
    property fpgVerificarDocFinalizado: boolean read FbVerificarDocFinalizado   
      write FbVerificarDocFinalizado;
    property fpgVerificarDocAssinado: boolean read FbVerificarDocAssinado 
      write FbVerificarDocAssinado;
    property fpgInserirMov: boolean read FbInserirMov write FbInserirMov;
    property fpgFinalizarPainelAuxiliar: boolean 
      read FbFinalizarPainelAuxiliar   write FbFinalizarPainelAuxiliar;
    property fpgModoFinalizacao: string read FsModoFinalizacao write FsModoFinalizacao;
    property fpgRgistrarMensagemModeloDependente: boolean   
      read FbRgistrarMensagemModeloDependente write FbRgistrarMensagemModeloDependente;
    property fpgRegistrarConfirmarConfiguracao: boolean   
      read FbRegistrarConfirmarConfiguracao write FbRegistrarConfirmarConfiguracao;
    property fpgPintarAmarelo: boolean read FbPintarAmarelo write FbPintarAmarelo;
    property fpgModelo: string read FsModelo write FsModelo;
    property fpgUsaProcesso: boolean read FbUsaProcesso write FbUsaProcesso;
    property fpgImprimirAR: boolean read FbImprimirAR write FbImprimirAR;
    property fpgNovoAto: boolean read FbNovoAto write FbNovoAto;
    property fpgGerarAto: boolean read FbGerarAto write FbGerarAto;
    property fpgRegistrarConfirmarConfiguracaoImpressao: boolean   
      read FbRegistrarConfirmarConfiguracaoImpressao write FbRegistrarConfirmarConfiguracaoImpressao;
    property fpgTipoAto: string read FsTipoAto write FsTipoAto;
    property fpgConvenio: string read FsConvenio write FsConvenio;
    property fpgFormaAto: string read FsFormaAto write FsFormaAto;
    property fpgPrazoAto: string read FsPrazoAto write FsPrazoAto;
    property fpgAbrirEdicaoModelo: boolean read FbAbrirEdicaoModelo write FbAbrirEdicaoModelo;
    property fpgModeloAto: string read FsModeloAto write FsModeloAto;
    property fpgImprotarMultimidia: boolean read FbImprotarMultimidia write FbImprotarMultimidia;
    property fpgFecharArquivo: boolean read FbFecharArquivo write FbFecharArquivo;
    property fpgMsgSemSalvar: boolean read FbMsgSemSalvar write FbMsgSemSalvar;
    property fpgEditarOficio: boolean read FbEditarOficio write FbEditarOficio;
    property fpgTipoDocumento: string read FsTipoDocumento write FsTipoDocumento;
    property fpgMovimentacao: string read FsMovimentacao write FsMovimentacao;
    property fpgLancarMovimentacao: boolean read FbLancarMovimentacao write FbLancarMovimentacao;
    property fpgRegistrarMsgNaoConfirmado: boolean 
      read FbRegistrarMsgNaoConfirmado   write FbRegistrarMsgNaoConfirmado;
    property fpgObservacao: string read FsObservacao write FsObservacao;
    property fpgInserirObeservacao: boolean read FbInserirObeservacao write FbInserirObeservacao;

    property fpgImportarMultimidia: boolean read FbImportarMultimidia write FbImportarMultimidia;
    property fpgRegistraMsgMandado: boolean read FbRegistraMsgMandado write FbRegistraMsgMandado;
    property fpgRegistrarMsgAssinaturaOficialJustica: boolean   
      read FbRegistrarMsgAssinaturaOficialJustica write FbRegistrarMsgAssinaturaOficialJustica;
    property fpgRegistrarMsgEscrivao: boolean read FbRegistrarMsgEscrivao 
      write FbRegistrarMsgEscrivao;
    property fpgFinalizaDocumentoMenu: boolean read FbFinalizaDocumentoMenu   
      write FbFinalizaDocumentoMenu;
    property fpgVerifcarCopiarColar: boolean read FbVerifcarCopiarColar 
      write FbVerifcarCopiarColar;
    property fpgInserirCompMovParagrafo: boolean 
      read FbInserirCompMovParagrafo   write FbInserirCompMovParagrafo;
    property fpgVerificaQtdeCaracter: boolean read FbVerificaQtdeCaracter 
      write FbVerificaQtdeCaracter;
    property fpgImprimirBotao: boolean read FbImprimirBotao write FbImprimirBotao;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

{ TffpgEditorModelTests }

class function TffpgEditorModelTests.VerificarDocEmitido(psCategoria, psModelo,
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgEditorModelTests.VerificarARGerada(psNumAR: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarARGerada(psNumAR);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

