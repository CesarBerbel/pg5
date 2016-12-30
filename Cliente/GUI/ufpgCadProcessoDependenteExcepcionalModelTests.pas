unit ufpgCadProcessoDependenteExcepcionalModelTests;

interface

uses
  ufpgCadProcessoDependenteExcepcional, ufpgDataModelTests, ADODB;

type
  TffpgCadProcessoDependenteExcepcionalModelTests = class(TfpgDataModelTests)
  private
    FsClasse: string;
    FsNuProcesso: string;

  public
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgClasse: string read FsClasse write FsClasse;
  end;

implementation

end.
  
