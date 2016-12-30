unit ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake;

interface

uses
  SysUtils, ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublica;

type
  TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake = class(
    TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublica)
  protected
    function PegarTiposPartesComConvenio: string; override;
  end;

implementation

{ TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake }

function TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublicaFake.PegarTiposPartesComConvenio: string;
begin
  result := '6,6,6';
end;

end.
  
