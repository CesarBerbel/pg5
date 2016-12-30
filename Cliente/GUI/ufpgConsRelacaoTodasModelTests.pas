unit ufpgConsRelacaoTodasModelTests;

interface

uses
  ufpgConsRelacaoTodas, ufpgModelTests, ADODB;

type
  TffpgConsRelacaoTodasModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FsNuProcesso: string;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

{ TffpgConsRelacaoTodasModelTests }


end.

