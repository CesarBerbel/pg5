unit ufpgAlternaLotacaoModelTests;

interface

uses
  ufpgDataModelTests, ADODB;

type
  TffpgAlternaLotacaoModelTests = class(TfpgDataModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsLotacaoAlternada: string;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgLotacaoAlternada: string read FsLotacaoAlternada write FsLotacaoAlternada;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

end.

