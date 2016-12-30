unit ufpgCadProcessoDependenteMoldelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadProcessoDependenteMoldelTests = class(TfpgModelTests)
  private
    FsCdClasse: string;
    FbUtilizaArquivoExterno: boolean;
    FsNuProcesso: string;
    FbCopiarPartes: boolean;
    FsAssuntoPrincipal: string;
    FbJuntarPeticao: boolean;
    FbFecharTela: boolean;
    FsNuProtocolo: string;
    FbAbrirDoMenu: boolean;
    FbApenser: boolean;
  published
    property fpgCdClasse: string read FsCdClasse write FsCdClasse;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgUtilizaArquivoExterno: boolean read FbUtilizaArquivoExterno   
      write FbUtilizaArquivoExterno;
    property fpgCopiarPartes: boolean read FbCopiarPartes write FbCopiarPartes;
    property fpgAssuntoPrincipal: string read FsAssuntoPrincipal write FsAssuntoPrincipal;
    property fpgJuntarPeticao: boolean read FbJuntarPeticao write FbJuntarPeticao;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgNuProtocolo: string read FsNuProtocolo write FsNuProtocolo;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgApenser: boolean read FbApenser write FbApenser;
  end;

implementation

end.

