#pragma once

#include <QUdpSocket>
#include <QByteArray>

struct IDataConsumer 
{
	virtual void TakeData(QByteArray data) = 0;
};

class DatagramListener : public QObject {
	Q_OBJECT
public:
	void Start();
	void Stop();
	bool IsInProgress() const;
	quint16 Port() const;

	void Bind(quint16 port);
	void SetConsumer(IDataConsumer* consumer);

private:
	void ProcessDatagrams();

private:
	bool m_is_in_progress = false;
	IDataConsumer* m_consumer = nullptr;
	quint16 m_port = 0;
	QUdpSocket m_socket;
};
