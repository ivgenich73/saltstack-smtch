copy python script file:
    file.managed:
        - name: /usr/share/pyshared/analyzer.py
        - source: salt://files/analyzer.py

analyze_access.log_every_minute:
  cron.present:
    - name: python3 /usr/share/pyshared/analyzer.py
    - user: root
    - minute: '*/1'