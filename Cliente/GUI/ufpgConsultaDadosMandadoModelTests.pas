unit ufpgConsultaDadosMandadoModelTests;

interface

uses
  ufpgConsultaDadosMandado, ufpgModelTests, ADODB;

type
  TffpgConsultaDadosMandadoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsNuMandado: string;
    FbConsultaPorProcesso: boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
    property fpgConsultaPorProcesso: boolean read FbConsultaPorProcesso 
      write FbConsultaPorProcesso;
  end;

implementation

{ TffpgConsultaDadosMandadoModelTests }

end.

