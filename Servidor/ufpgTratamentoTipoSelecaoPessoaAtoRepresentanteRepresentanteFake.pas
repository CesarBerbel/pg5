unit ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake;

interface

uses
  SysUtils, ufpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentante;

type
  TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake = class(
    TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentante)
  protected
    function PegarFiltroNuSeqParteRefer(var pnTpParte: integer;
      const psCdProcesso: string): string;
      override;
  end;

implementation

{ TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake }

function TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentanteFake.
PegarFiltroNuSeqParteRefer(
  var pnTpParte: integer; const psCdProcesso: string): string;
begin
  result := '(nuSeqParteRefer = 666)';
end;

end.

