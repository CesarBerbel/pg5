unit ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublica,
  ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake, ufpgFiltroTipoSelecaoAto, usajConstante;

type
  TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests = class(TspTestCase)
  private
    FoDefensoriaPublica: TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarFiltroSelecaoDefensoriaPublica;
  end;

const
  sFILTRO_ESPERADO = '(cdTipoParte in (6,6,6))';
  sFILTRO_BASE = STRING_INDEFINIDO;

implementation

uses
  uedtConstantes;

{ TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests }

procedure TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests.SetUp;
begin
  FoDefensoriaPublica := TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake.Create(null);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests.TearDown;
begin
  FreeAndNil(FoDefensoriaPublica);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests.
TestarFiltroSelecaoDefensoriaPublica;
var
  sFiltro: string;
begin
  sFiltro := FoDefensoriaPublica.TratarFiltroTipoSelecaoAto('123', sFILTRO_BASE);
  CheckTrue((sFiltro = sFILTRO_ESPERADO),
    'O filtro esperado foi diferente do retorno do tratamento');
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Servidor\ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests',
    TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaTests.Suite);

end.

