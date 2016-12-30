unit ufpgDadosAdicionaisPartesEtiquetaAutuacaoFake;

interface

uses
  ufpgDadosAdicionaisPartesEtiquetaAutuacao, uspTestCase;

type
  TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake = class(TfpgDadosAdicionaisPartesEtiquetaAutuacao)
  protected
    function PegarListaCompetenciasImpressaoDtNascimento: string; override;
    function PegarListaCompetenciasImprimemProntuario: string; override;
    function PegarTamanhoTexto(const psTexto: string): integer; override;
  end;

implementation

function TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake.PegarListaCompetenciasImpressaoDtNascimento: string;
const
  sCOMPETENCIAS_IMPRESSAO_DTNASCIMENTO = '1, 2, 3, 875';
begin
  result := sCOMPETENCIAS_IMPRESSAO_DTNASCIMENTO;
end;

function TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake.PegarListaCompetenciasImprimemProntuario: string;
const
  sCOMPETENCIAS_IMPRESSAO_PRONTUARIO = '5, 8, 13, 875';
begin
  result := sCOMPETENCIAS_IMPRESSAO_PRONTUARIO;
end;

function TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake.PegarTamanhoTexto(
  const psTexto: string): integer;
begin
  result := Length(psTexto);
end;

end.

