unit ufpgConsProcAvancadaModelTests;

interface

uses
  SysUtils, ufpgModelTests, ADODB, FutureWindows;

type
  TffpgConsProcAvancadaModelTests = class(TfpgModelTests)
  private
    FbConsultarNomeCompleto: boolean;
    FbConsultarNomeParcial: boolean;
    FbConsultarCPF: boolean;
    FsNomeParteRepresentante: string;
    FsNomeParteTestemunha: string;
    FsNomeParteAtiva: string;
    FsCPFPartePassiva: string;
    FsCPFParteRepresentante: string;
    FsCPFParteTestemunha: string;
    FsCPFParteAtiva: string;
    FsNomePartePassiva: string;
  published
    property fpgConsultarNomeCompleto: boolean read FbConsultarNomeCompleto write FbConsultarNomeCompleto;
    property fpgConsultarNomeParcial: boolean read FbConsultarNomeParcial write FbConsultarNomeParcial;
    property fpgConsultarCPF: boolean read FbConsultarCPF write FbConsultarCPF;
    property fpgNomeParteAtiva: string read FsNomeParteAtiva write FsNomeParteAtiva;
    property fpgNomePartePassiva: string read FsNomePartePassiva write FsNomePartePassiva;
    property fpgNomeParteRepresentante: string read FsNomeParteRepresentante write FsNomeParteRepresentante;
    property fpgNomeParteTestemunha: string read FsNomeParteTestemunha write FsNomeParteTestemunha;
    property fpgCPFParteAtiva: string read FsCPFParteAtiva write FsCPFParteAtiva;
    property fpgCPFPartePassiva: string read FsCPFPartePassiva write FsCPFPartePassiva;
    property fpgCPFParteRepresentante: string read FsCPFParteRepresentante write FsCPFParteRepresentante;
    property fpgCPFParteTestemunha: string read FsCPFParteTestemunha write FsCPFParteTestemunha;

  end;

implementation

end.

