# -*- coding: utf-8 -*-

import StringIO
import sys
import unittest,click,time

import HTMLTestRunner

from  exportacao.check.step_2_aggs import ExportAggs 
from  exportacao.check.step_3_indicators import ExportIndicators
from  exportacao.check.step_4_sent import ExportSent
from  exportacao.check.step_5_site import ExportSite

from  emprego.check.step_2_aggs import EmpregoAggs 
from  emprego.check.step_3_indicators import EmpregoIndicators
from  emprego.check.step_4_sent import EmpregoSent

from  educacaosuperior.check.step_2_aggs import EducacaoSuperiorAggs
from  educacaosuperior.check.step_4_sent import EducacaoSuperiorSent

from  censoescolar.check.step_1_aggs import CensoEscolarAggs


from  nfe.check.step_2_aggs import NfeAggs
from  nfe.check.step_4_sent import NfeSent



class runtests(unittest.TestCase):


    def test_main(self):



        # suite of TestCases
        self.suite = unittest.TestSuite()
        

        if len(sys.argv)>1:
            database=sys.argv[2]
            
        rais=False
        secex=False
        censoescolar=False
        educacaosuperior=False
        nfe=False        
        if database=='rais' or database=="all":
            rais=True
        if database=='secex' or database=="all":
            secex=True
        if database=='censoescolar' or database=="all":
            censoescolar=True
        if database=='educacaosuperior' or database=="all":
            educacaosuperior=True
        if database=='nfe' or database=="all":
            nfe=True

                    
        if rais:
            self.suite.addTests([                 
                unittest.defaultTestLoader.loadTestsFromTestCase(EmpregoAggs),
               unittest.defaultTestLoader.loadTestsFromTestCase(EmpregoIndicators) , 
                unittest.defaultTestLoader.loadTestsFromTestCase(EmpregoSent)  
                ])

        if secex:
            self.suite.addTests([            
                unittest.defaultTestLoader.loadTestsFromTestCase(ExportAggs),
               unittest.defaultTestLoader.loadTestsFromTestCase(ExportIndicators), 
                unittest.defaultTestLoader.loadTestsFromTestCase(ExportSent),
                unittest.defaultTestLoader.loadTestsFromTestCase(ExportSite)
                ])

        if educacaosuperior:
            self.suite.addTests([            
                unittest.defaultTestLoader.loadTestsFromTestCase(EducacaoSuperiorAggs),
                unittest.defaultTestLoader.loadTestsFromTestCase(EducacaoSuperiorSent)
                ])
            
        if censoescolar:
            self.suite.addTests([            
                unittest.defaultTestLoader.loadTestsFromTestCase(CensoEscolarAggs)
                ])            

        if nfe:
            self.suite.addTests([            
                unittest.defaultTestLoader.loadTestsFromTestCase(NfeAggs),
                unittest.defaultTestLoader.loadTestsFromTestCase(NfeSent)
                ])         
                    
        # Invoke TestRunner
        buf = StringIO.StringIO()
        #runner = unittest.TextTestRunner(buf)       #DEBUG: this is the unittest baseline
        runner = HTMLTestRunner.HTMLTestRunner(
                    stream=buf,
                    title='<Demo Test>',
                    description='This demonstrates the report output by HTMLTestRunner.'
                    )
        runner.run(self.suite)

      
        # check out the output
        byte_output = buf.getvalue()
        # output the main test output for debugging & demo
        print byte_output
        # HTMLTestRunner pumps UTF-8 output
        output = byte_output.decode('utf-8')



@click.command()
@click.option('-d', '--database', prompt='database', help='chosse a database to run : rais, secex, censoescolar,educacaosuperior,nfe or all' ,required=False)
def mainexec(database=None):
    
    argv=['runtests.py', 'runtests']

    unittest.main(argv=argv)


if __name__ == "__main__":
    start = time.time()
    
    mainexec()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;
    