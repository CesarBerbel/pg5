unit ufpgFormLoginModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgFormLoginModelTests = class(TfpgModelTests)
  private
    FsUsuarioCerto: string;

  published
    property fpgUsuarioCerto: string read FsUsuarioCerto write FsUsuarioCerto;
  end;

implementation

end.

