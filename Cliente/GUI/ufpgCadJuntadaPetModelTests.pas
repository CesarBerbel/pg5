unit ufpgCadJuntadaPetModelTests;

interface

uses
  ufpgCadJuntadaPet, ufpgModelTests, SysUtils, usajConstante, uspFuncoesDate;

type
  TffpgCadJuntadaPetModelTests = class(TfpgModelTests)
  private
    FsSemCustasIniciais: boolean;
    FsPartesAtivas: string;
    FsCivel: boolean;
    FsDistribuido: boolean;
    FsNuProcesso: string;
    FsClasse: string;
    FbUtilizaArquivoExterno: boolean;
    FbAbrirDoMenu: boolean;
    FbUsarVariavelGlobal: boolean;
  public
    bFisico: boolean;
    bFinalizado: boolean;
    bNuprotocolo: boolean;
    function VerificarJuntada(psNuProcesso: string): boolean;
  published
    property fpgDistribuido: boolean read FsDistribuido write FsDistribuido;
    property fpgCivel: boolean read FsCivel write FsCivel;
    property fpgSemCustasIniciais: boolean read FsSemCustasIniciais write FsSemCustasIniciais;
    property fpgPartesAtivas: string read FsPartesAtivas write FsPartesAtivas;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgUtilizaArquivoExterno: boolean read FbUtilizaArquivoExterno   
      write FbUtilizaArquivoExterno;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgUsarVariavelGlobal: boolean read FbUsarVariavelGlobal write FbUsarVariavelGlobal;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgCadJuntadaPetModelTests }

function TffpgCadJuntadaPetModelTests.VerificarJuntada(psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarJuntadaSql(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

