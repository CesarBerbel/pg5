unit ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentante,
  ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake, usajConstante;

type
  TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests = class(TspTestCase)
  private
    FoRepresRepresentante: TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarFiltroSelecaoAdvRepresentante;
  end;

const
  sFILTRO_ESPERADO = '(TpParte = 5 and (nuSeqParteRefer = 666))';
  sFILTRO_BASE = '(TpParte = 5 and nuSeqParteRefer = 3)';

implementation

uses
  uedtConstantes;

{ TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests }

procedure TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests.SetUp;
begin
  FoRepresRepresentante := TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake.Create(null);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests.TearDown;
begin
  FreeAndNil(FoRepresRepresentante);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests.
TestarFiltroSelecaoAdvRepresentante;
var
  sFiltro: string;
begin
  sFiltro := FoRepresRepresentante.TratarFiltroTipoSelecaoAto('123', sFILTRO_BASE);
  CheckTrue((sFiltro = sFILTRO_ESPERADO),
    'O filtro esperado foi diferente do retorno do tratamento');
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Servidor\ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests',
    TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteTests.Suite);

end.
 
