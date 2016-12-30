unit ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes,
  ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake, ufpgFiltroTipoSelecaoAto;

type
  TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests = class(TspTestCase)
  private
    FoAdvParteAtiva: TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake;
    FoAdvPartePassiva: TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarFiltroSelecaoAdvParteAtiva;
    procedure TestarFiltroSelecaoAdvPartePassiva;
  end;

const
  sFILTRO_ESPERADO = '(TpParte = 4 and (nuSeqParteRefer = 666))';
  sFILTRO_ATIVA = '(TpParte = 4 and nuSeqParteRefer = 1)';
  sFILTRO_PASSIVA = '(TpParte = 4 and nuSeqParteRefer = 2)';

implementation

uses
  uedtConstantes;

{ TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests }

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests.SetUp;
begin
  FoAdvParteAtiva := TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake.Create(null, True);   //PC_OK
  FoAdvPartePassiva := TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake.Create(null, False);//PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests.TearDown;
begin
  FreeAndNil(FoAdvParteAtiva);   //PC_OK
  FreeAndNil(FoAdvPartePassiva); //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests.TestarFiltroSelecaoAdvParteAtiva;
var
  sFiltro: string;
begin
  sFiltro := FoAdvParteAtiva.TratarFiltroTipoSelecaoAto('123', sFILTRO_ATIVA);
  CheckTrue((sFiltro = sFILTRO_ESPERADO),
    'O filtro esperado foi diferente do retorno do tratamento');
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests.
TestarFiltroSelecaoAdvPartePassiva;
var
  sFiltro: string;
begin
  sFiltro := FoAdvPartePassiva.TratarFiltroTipoSelecaoAto('123', sFILTRO_PASSIVA);
  CheckTrue((sFiltro = sFILTRO_ESPERADO),
    'O filtro esperado foi diferente do retorno do tratamento');
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Servidor\ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests',
    TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesTests.Suite);

end.

