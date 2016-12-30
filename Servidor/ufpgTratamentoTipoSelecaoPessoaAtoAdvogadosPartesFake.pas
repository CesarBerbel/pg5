unit ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake;

interface

uses
  SysUtils, ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes;

type
  TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake = class(
    TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes)
  protected
    function PegarFiltroNuSeqParteRefer(var pnTpParteConsulta: integer;
      const psCdProcesso: string): string; override;
  end;

implementation

{ TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake }

function TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartesFake.PegarFiltroNuSeqParteRefer(
  var pnTpParteConsulta: integer; const psCdProcesso: string): string;
begin
  result := '(nuSeqParteRefer = 666)';
end;

end.

