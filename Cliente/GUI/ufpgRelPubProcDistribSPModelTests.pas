unit ufpgRelPubProcDistribSPModelTests;

interface

uses
  ufpgRelPubProcDistribSP, ufpgModelTests, ADODB;

type
  TffpgRelPubProcDistribSPModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FsPeriodoInicial: string;
    FsPeriodoFinal: string;
    FsForo: string;
    FbGeraProcCiveis: boolean;
    FbGeraPrecCiveis: boolean;
    FbGeraProcCriminais: boolean;
    FbGeraPrecCriminais: boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgPeriodoInicial: string read FsPeriodoInicial write FsPeriodoInicial;
    property fpgPeriodoFinal: string read FsPeriodoFinal write FsPeriodoFinal;
    property fpgForo: string read FsForo write FsForo;
    property fpgGeraProcCiveis: boolean read FbGeraProcCiveis write FbGeraProcCiveis;
    property fpgGeraProcCriminais: boolean read FbGeraProcCriminais write FbGeraProcCriminais;
    property fpgGeraPrecCiveis: boolean read FbGeraPrecCiveis write FbGeraPrecCiveis;
    property fpgGeraPrecCriminais: boolean read FbGeraPrecCriminais write FbGeraPrecCriminais;
  end;

implementation

{ TffpgRelPubProcDistribSPModelTests }


end.

