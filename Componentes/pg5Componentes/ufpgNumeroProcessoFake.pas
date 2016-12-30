unit ufpgNumeroProcessoFake;

interface

uses
  usajNumeroProcesso;

type
  TfpgNumeroProcessoFake = class(TsajNumeroProcesso)
  public
    function PegaTextoMascarado: string; override;
  end;

implementation

const
  sNUM_PROCESSO_MASCARADO = '0000093-17.2014.8.26.0666';


{ TfpgNumeroProcessoFake }

function TfpgNumeroProcessoFake.PegaTextoMascarado: string;
begin
  result := sNUM_PROCESSO_MASCARADO;
end;

end.

