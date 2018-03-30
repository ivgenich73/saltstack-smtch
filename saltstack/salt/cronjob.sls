analyze_access.log_every_minute:
  cron.present:
    - name: python3 /xchng/analyzer.py
    - user: root
    - minute: '*/1'