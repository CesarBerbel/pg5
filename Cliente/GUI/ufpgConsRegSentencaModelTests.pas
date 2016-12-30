unit ufpgConsRegSentencaModelTests;

interface

uses
  ufpgConsRegSentenca, ufpgModelTests, ADODB;

type
  TffpgConsRegSentencaModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsNuVara: string;
  published
    property fpgNuVara: string read FsNuVara write FsNuVara;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

{ TffpgConsRegSentencaModelTests }

end.

