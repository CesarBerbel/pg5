unit ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake;

interface

uses
  SysUtils, ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentante;

type
  TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake = class(
    TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentante)
  protected
    function PegarFiltroNuSeqParteRefer(var pnTpParte: integer;
      const psCdProcesso: string): string;
      override;
  end;

implementation

{ TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake }

function TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentanteFake.PegarFiltroNuSeqParteRefer(
  var pnTpParte: integer; const psCdProcesso: string): string;
begin
  result := '(nuSeqParteRefer = 666)';
end;

end.
  
