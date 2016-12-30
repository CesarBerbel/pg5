
unit ufpgAlteracaoFormaPgtoModelTests;

interface

uses
  ufpgDataModelTests;

type
  TffpgAlteracaoFormaPgtoModelTests = class(TfpgDataModelTests)
  private
    FsNuProcesso, FsNuMandado, FsCdFormaPgto, FsCdMunicipio, FsSelecionaNaGrid,
    FsVincularGuia: string;
    FbAlterarParaMesmaFormaPagto: boolean;
    FbSemInformarMunicipio: boolean;
  public
    class function VerficarAlteracaoFormaPgto(psCDMandado, psCdFormaPagto: string): boolean;
  published
    property fpgAlterarParaMesmaFormaPagto: boolean 
      read FbAlterarParaMesmaFormaPagto   write FbAlterarParaMesmaFormaPagto;
    property fpgSemInformarMunicipio: boolean read FbSemInformarMunicipio 
      write FbSemInformarMunicipio;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
    property fpgCdMunicipio: string read FsCdMunicipio write FsCdMunicipio;
    property fpgCdFormaPgto: string read FsCdFormaPgto write FsCdFormaPgto;
    property fpgSelecionaNaGrid: string read FsSelecionaNaGrid write FsSelecionaNaGrid;
    property fpgVincularGuia: string read FsVincularGuia write FsVincularGuia;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SySUtils;

{ TffpgAlteracaoFormaPgtoModelTests }

class function TffpgAlteracaoFormaPgtoModelTests.VerficarAlteracaoFormaPgto(
  psCDMandado, psCdFormaPagto: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerficarAlteracaoFormaPgto(psCDMandado, psCdFormaPagto);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

