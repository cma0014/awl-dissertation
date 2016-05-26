(TeX-add-style-hook "timeseries"
 (lambda ()
    (LaTeX-add-bibliographies
     "timeseries.bib")
    (LaTeX-add-labels
     "sec:Introduction"
     "sec:priorwork"
     "sec:evaluation"
     "sec:conclusions"
     "sec:acknowledgements"
     "sec:references")
    (TeX-run-style-hooks
     "fix2col"
     "fixltx2e"
     "subfig"
     "url"
     "array"
     "amsmath"
     "cmex10"
     "graphicx"
     "pdftex"
     "cite"
     "nocompress"
     "latex2e"
     "IEEEtran10"
     "IEEEtran"
     "10pt"
     "journal"
     "cspaper"
     "compsoc")))

