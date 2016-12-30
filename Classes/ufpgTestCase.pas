unit ufpgTestCase;

interface

uses
  Classes, uspTestCase, uspClientDataSet, ufpgDUnitDAO, ufpgDataModelTests,
  GUITesting, GUITestRunner;

type

  TfpgTestCase = class(TspTestCase)
  private
    FoDados: TspClientDataSet;
    FoClasseModelTests: TfpgDataModelTestsClass;
  protected
    FoModelTests: TfpgDataModelTests;
    function PegarClasseModelTests: TfpgDataModelTestsClass; reintroduce; virtual;
  public
    property spDados: TspClientDataSet read FoDados write FoDados;
    function PegarDadosTeste(poCDS: TspClientDataSet; const psArquivo, psAba: string;
      psID: string = ''): boolean;
  end;

implementation

{ TfpgTestCase }

function TfpgTestCase.PegarDadosTeste(poCDS: TspClientDataSet;
  const psArquivo, psAba: string; psID: string): boolean;
begin
  result := TfpgDUnitDAO.PegarInstancia.PegarDadosTeste(poCDS, psArquivo, psAba, psID);
end;

function TfpgTestCase.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  if FoClasseModelTests = nil then
    result := TfpgDataModelTests
  else
    result := FoClasseModelTests;
end;


end.

