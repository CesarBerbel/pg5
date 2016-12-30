unit ufpgCalcCustaCompletaIntermediariaProcModelTests;

interface

uses
  ufpgModelTests, ADODB;

type
  TffpgCalcCustaCompletaIntermediariaProcModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
    FbPossuiPorcesso: boolean;
    FsKm: string;
    FsTipoCusta: string;
    FsVlInformado: string;
    FsTpRelatorio: string;
    FsEndereco: string;
    FsQtdeAtos: string;
    FsInteressado: string;
    FsQtdeJusPaga: string;
  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
  published
    property fpgPossuiPorcesso: boolean read FbPossuiPorcesso write FbPossuiPorcesso;
    property fpgInteressado: string read FsInteressado write FsInteressado;
    property fpgEndereco: string read FsEndereco write FsEndereco;
    property fpgTpRelatorio: string read FsTpRelatorio write FsTpRelatorio;
    property fpgQtdeAtos: string read FsQtdeAtos write FsQtdeAtos;
    property fpgQtdeJusPaga: string read FsQtdeJusPaga write FsQtdeJusPaga;
    property fpgVlInformado: string read FsVlInformado write FsVlInformado;
    property fpgKm: string read FsKm write FsKm;
    property fpgTipoCusta: string read FsTipoCusta write FsTipoCusta;
  end;

implementation

end.

