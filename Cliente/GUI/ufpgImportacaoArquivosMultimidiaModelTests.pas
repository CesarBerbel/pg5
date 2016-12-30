unit ufpgImportacaoArquivosMultimidiaModelTests;

interface

uses
  ufpgModelTests, ADODB;

type
  TffpgImportacaoArquivosMultimidiaModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
    FsAbrirDoMenu: boolean;
    FsMotivo: string;
    FsNomeArquivo: string;
    FsCertificado: string;
    FbFecharTela: boolean;
    FbRegistrarMensagem: boolean;
  published
    property fpgNuProcesso: string read FsProcesso write FsProcesso;
    property fpgAbrirDoMenu: boolean read FsAbrirDoMenu write FsAbrirDoMenu;
    property fpgNomeArquivo: string read FsNomeArquivo write FsNomeArquivo;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgRegistrarMensagem: boolean read FbRegistrarMensagem write FbRegistrarMensagem;
  end;

implementation

end.

