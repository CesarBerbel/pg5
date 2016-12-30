unit ufpgCancelJuntadaPetModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCancelJuntadaPetModelTests = class(TfpgModelTests)

  private
    FsMotivo: string;
    FsNuProcesso: string;
    FbUsaProcesso: boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgUsaProcesso: boolean read FbUsaProcesso write FbUsaProcesso;
  end;

implementation

end.

