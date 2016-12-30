unit ufpgCadContatoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadContatoModelTests = class(TfpgModelTests)
  private
    FsNomePessoa: string;
    FbTemCPF: boolean;
    FsCEP: string;
  public
    class function RetornaContato(psCPF: string): boolean;
  published
    property fpgNomePessoa: string read FsNomePessoa write FsNomePessoa;
    property fpgTemCPF: boolean read FbTemCPF write FbTemCPF;
    property fpgCEP: string read fsCEP write fsCEP;
  end;

implementation

uses
  ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, usegRepositorio, SysUtils;

{ TffpgCadContatoModelTests }

class function TffpgCadContatoModelTests.RetornaContato(psCPF: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarCadastroContatoSql(psCPF);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.
                                                           
