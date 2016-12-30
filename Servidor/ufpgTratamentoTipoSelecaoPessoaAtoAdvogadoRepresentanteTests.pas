unit ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentante,
  ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake, usajConstante;

type
  TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests = class(TspTestCase)
  private
    FoAdvRepresentante: TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarFiltroSelecaoAdvRepresentante;
  end;

const
  sFILTRO_ESPERADO = '(TpParte = 4 and (nuSeqParteRefer = 666))';
  sFILTRO_BASE = '(TpParte = 4 and nuSeqParteRefer = 3)';

implementation

uses
  uedtConstantes;

{ TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests }

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests.SetUp;
begin
  FoAdvRepresentante := TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake.Create(null);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests.TearDown;
begin
  FreeAndNil(FoAdvRepresentante);   //PC_OK
  inherited;
end;

procedure TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests.
TestarFiltroSelecaoAdvRepresentante;
var
  sFiltro: string;
begin
  sFiltro := FoAdvRepresentante.TratarFiltroTipoSelecaoAto('123', sFILTRO_BASE);
  CheckTrue((sFiltro = sFILTRO_ESPERADO),
    'O filtro esperado foi diferente do retorno do tratamento');
end;

initialization
  TestFrameWork.RegisterTest(
    'Unitário\PG5\Servidor\ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests',
    TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteTests.Suite);

end.

